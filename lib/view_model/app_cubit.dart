import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/m_storage.dart';
import 'package:social_app/view_model/app_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AppCubit extends Cubit<AppState>{
  AppCubit()  : super (AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  List<String> postsId = [];
  Map<String,int> likesCount = {};
  Map<String,bool> isLikedList = {};
  Map<String,int> commentsCount = {};
  List<UserModel> users = [];

  UserModel user;
  void getUserData(){
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc(mStorage.getToken('token')).
    get().
    then((value) {
      user = UserModel.fromMap(value.data());
      emit(AppGetUserSuccessState());
    }).
    catchError((error){
      print(error.toString());
      emit(AppGetUserErrorState());
    });
  }

  File profileImage;
  Future<void> pickProfileImage() async{
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileImage = File(pickedFile.path);
      emit(AppProfileLoadingState());
      if(profileImage != null){
        firebase_storage.
        FirebaseStorage.
        instance.ref().
        child('images/${Uri.file(profileImage.path).pathSegments.last}').
        putFile(profileImage).then((value) {
          value.ref.getDownloadURL().then((value) {
            UserModel model = UserModel(
                user.name,
                user.phone,
                user.uId,
                user.email,
                value,
                user.cover,
                user.bio,
            );
            FirebaseFirestore.instance.
            collection('users').
            doc(user.uId).
            update(model.toMap()).then((value) {
              getUserData();
            }).catchError((onError){
              print(onError.toString());
            });
          }).catchError((error){
            print('error : ' + error.toString());
          });
        }).catchError((error){
          print('error : ' + error.toString());
        });
      }
      emit(AppProfileSuccessState());
    }else{
      print('No Selected Image');
      emit(AppProfileErrorState());
    }
  }

  File coverImage;
  Future<void> pickCoverImage() async{
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      coverImage = File(pickedFile.path);
      emit(AppCoverLoadingState());
      if(coverImage != null){
        firebase_storage.
        FirebaseStorage.
        instance.ref().
        child('images/${Uri.file(coverImage.path).pathSegments.last}').
        putFile(coverImage).then((value) {
          value.ref.getDownloadURL().then((value) {
            UserModel model = UserModel(
              user.name,
              user.phone,
              user.uId,
              user.email,
              user.image,
              value,
              user.bio,
            );
            FirebaseFirestore.instance.
            collection('users').
            doc(user.uId).
            update(model.toMap()).then((value) {
              getUserData();
            }).catchError((onError){
              print(onError.toString());
            });
          }).catchError((error){
            print('error : ' + error.toString());
          });
        }).catchError((error){
          print('error : ' + error.toString());
        });
      }
      emit(AppCoverSuccessState());
    }else{
      print('No Selected Image');
      emit(AppCoverErrorState());
    }
  }

  void updateProfile(String name,String phone,String bio){
    emit(UpdateLoadingState());
    UserModel model = UserModel(
        name,
        phone,
        user.uId,
        user.email,
        user.image,
        user.cover ,
        bio,
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(user.uId).
    update(model.toMap()).then((value) {
      getUserData();
    }).catchError((onError){
      print(onError.toString());
      emit(UpdateErrorState());
    });
  }

  File imagePost;
  Future<void> getPostImage() async{
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      imagePost = File(pickedFile.path);
      emit(AddPhotoPostSuccessState());
    }else{
      print('no photo selected');
      emit(AddPhotoPostErrorState());
    }
  }

  Future<void> createNewPostWithImage({
      @required String dateTime,
      @required String postText,
  }) async{
      firebase_storage.
      FirebaseStorage.
      instance.ref().
      child('posts/${Uri
          .file(imagePost.path)
          .pathSegments
          .last}${DateTime.now().microsecond.toString()}').
      putFile(imagePost).then((value) {
        value.ref.getDownloadURL().then((value) {
          print('image : $value');
          createNewPost(postPhoto: value, dateTime: dateTime, postText: postText);
          emit(CreatePostLoadingState());
        }).catchError((error) {
          print('error : ' + error.toString());
          emit(CreatePostErrorState());
        });
      }).catchError((error) {
        print('error : ' + error.toString());
        emit(CreatePostErrorState());
      }
      );
  }

  void createNewPost({
    String postPhoto,
    @required String dateTime,
    @required String postText,
  }) {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      uId: user.uId,
      userName: user.name,
      userPhoto: user.image,
      postText: postText,
      postPhoto: postPhoto??'',
      dateTime: dateTime,
    );
    FirebaseFirestore.
    instance.
    collection('posts').
    add(model.toMap()).then((value) {
      print('path ${value.parent.toString()}');
      // FirebaseFirestore.
      // instance.
      // collection('posts').doc(value.id).set({'postId' : value.id});
      emit(CreatePostSuccessState());
      getAllPosts();
    }).catchError((error){
      print('error : ${error.toString()}');
      emit(CreatePostErrorState());
    });
  }

  void getAllPosts(){
    emit(GetPostsLoadingState());
    posts = [];
    postsId = [];
    FirebaseFirestore.instance.
    collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likesCount[element.id] = value.docs.length;
          isLiked(element.id);
          postsId.add(element.id);
          posts.add(PostModel.fromMap(element.data()));
          emit(GetPostsSuccessState());
        }).catchError((onError){});
        element.reference.collection('comments').get().then((value) {
          commentsCount[element.id] = value.docs.length;
        }).catchError((onError){});
        emit(GetPostsSuccessState());
      });
    }).catchError((error){
      emit(GetPostsErrorState());
    });
  }

  void closePostImage(){
    imagePost = null;
    emit(ClosePostImageState());
  }

  void likePost(String postId){
    isLikedList[postId] = !isLikedList[postId];
    emit(AddPostLikesLoadingState());
    FirebaseFirestore.
    instance.
    collection('posts').
    doc(postId).
    collection('likes').
    doc(user.uId).set({
      'like' : isLikedList[postId],
    }).then((value) {
      if(isLikedList[postId] == false){
        FirebaseFirestore.
        instance.
        collection('posts').
        doc(postId).
        collection('likes').
        doc(user.uId).delete();
        likesCount[postId] = likesCount[postId]-1;
      }
      else{
        likesCount[postId] = likesCount[postId]+1;
      }
      emit(AddPostLikesSuccessState());
    }).catchError((error){
      emit(AddPostLikesErrorState());
    });
  }

  void isLiked(String postId){
      FirebaseFirestore.
      instance.
      collection('posts').
      doc(postId).
      collection('likes').
      doc(user.uId).get().then((value) {
        print(value.data()['like'].toString());
        isLikedList[postId] = value.data()['like'];
        emit(IsLikedSuccessState());
      }).catchError((onError){
        isLikedList[postId] = false;
        emit(IsLikedErrorState());
      });
  }

  void commentPost(String postId,String comment){
    emit(AddCommentLoadingState());
    CommentModel commentModel =
    CommentModel(
        uId: user.uId,
        userName: user.name,
        userPhoto: user.image,
        dateTime: DateTime.now().toString(),
        comment: comment
    );
    FirebaseFirestore.
    instance.
    collection('posts').
    doc(postId).
    collection('comments').add(commentModel.toMap()).then((value) {
      commentsCount[postId] = commentsCount[postId]+1;
      comments.add(commentModel);
      emit(AddCommentSuccessState());
    }).catchError((error){
      emit(AddCommentErrorState());
    });
  }

  List<CommentModel> comments = [];
  void getComments(String postId){
    comments = [];
    emit(GetCommentsLoadingState());
    FirebaseFirestore.
    instance.
    collection('posts').
    doc(postId).
    collection('comments').
    get().
    then((value) {
      value.docs.forEach((element) {
        comments.add(CommentModel.fromMap(element.data()));
      });
      emit(GetCommentsSuccessState());
    }).catchError((onError){
      emit(GetCommentsErrorState());
    });
  }

  void getAllUserData(){
    emit(AppGetAllUserLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    get().
    then((value) {
      value.docs.forEach((element) {
        if(UserModel.fromMap(element.data()).uId != user.uId)
          users.add(UserModel.fromMap(element.data()));
      });
      emit(AppGetAllUserSuccessState());
    }).
    catchError((error){
      print(error.toString());
      emit(AppGetAllUserErrorState());
    });
  }

  void sendMessage({
    @required recieverId,
    @required message,
    @required dateTime,
  }){
    MessageModel messageModel = MessageModel(user.uId,recieverId,dateTime,message);

    FirebaseFirestore.instance.
    collection('users').
    doc(user.uId).
    collection('chats').
    doc(recieverId).
    collection('messages').
    add(messageModel.toMap()).
    then((value) => emit(AppSendMessageSuccessState())).
    catchError((onError) => emit(AppSendMessageErrorState()));
    
    FirebaseFirestore.instance.
    collection('users').
    doc(recieverId).
    collection('chats').
    doc(recieverId).
    collection('messages').
    add(messageModel.toMap()).
    then((value) => emit(AppSendMessageSuccessState())).
    catchError((onError) {
      emit(AppSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({@required String recieverId}){
    FirebaseFirestore.instance.
    collection('users').
    doc(user.uId).
    collection('chats').
    doc(recieverId).
    collection('messages').
    orderBy('dateTime').
    snapshots().
    listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromMap(element.data()));  
      });
      emit(AppGetMessagesSuccessState());
    });
  }
}