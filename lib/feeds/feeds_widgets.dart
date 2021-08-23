import 'package:flutter/material.dart';
import 'package:social_app/comments/comment_screen.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/icon_broken.dart';
import 'package:social_app/view_model/app_cubit.dart';

Widget buildCommunicateItem(BuildContext context){
  return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 15),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://image.freepik.com/free-photo/portrait-happy-amazed-young-beautiful-lady-with-curly-dark-hair-heard-cool-news-broadly-smiling-looking-camera-pointing-with-finger-copy-space-isolated-pink-background_295783-3092.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Communicate with your friends',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),),
          ),
        ],
      ),
  );
}

Widget buildPostItem(BuildContext context,PostModel post,int index){
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 3,
    margin: EdgeInsets.symmetric(horizontal: 15),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(post.userPhoto),
                radius: 20,
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(post.userName,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16,height: 1.4),),
                        SizedBox(width: 5,),
                        Icon(Icons.check_circle,color: Colors.blue,size: 16,),
                      ],
                    ),
                    Text(post.dateTime,style: Theme.of(context).textTheme.caption.copyWith(height: 1.4),),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,),iconSize: 16,),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[200],
          ),
          SizedBox(height: 5,),
          Text(post.postText,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16,fontWeight: FontWeight.w500,height: 1.3),),
          // Container(
          //   width: double.infinity,
          //   child: Wrap(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsetsDirectional.only(end: 5),
          //         child: Container(
          //           height: 25,
          //           child: MaterialButton(
          //             height: 25,
          //             minWidth: 1,
          //             onPressed: (){},
          //             padding: EdgeInsets.zero,
          //             child: Text('#Software',style: Theme.of(context).textTheme.caption.copyWith(color: Colors.blue)
          //             ),
          //           ),
          //         ),
          //       ),
          //       // Padding(
          //       //   padding: const EdgeInsetsDirectional.only(end: 5),
          //       //   child: Container(
          //       //     height: 25,
          //       //     child: MaterialButton(
          //       //       height: 25,
          //       //       minWidth: 1,
          //       //       onPressed: (){},
          //       //       padding: EdgeInsets.zero,
          //       //       child: Text('#Software_development',style: Theme.of(context).textTheme.caption.copyWith(color: Colors.blue)
          //       //       ),
          //       //     ),
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          if(post.postPhoto.isNotEmpty)
            Column(
              children: [
                SizedBox(height: 5,),
                Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(post.postPhoto),
                    fit: BoxFit.cover,
                  ),
                ),
          ),
              ],
            ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 30,
                    child: InkWell(
                      onTap: (){},
                      child: Row(children: [
                        Icon(IconBroken.Heart,color: Colors.red,),
                        SizedBox(width: 5,),
                        Text('${AppCubit.get(context).likesCount[AppCubit.get(context).postsId[index]]}'),
                      ],),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 30,
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, CommentScreen(postId: AppCubit.get(context).postsId[index]));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Icon(IconBroken.Chat,color: Colors.amber,),
                        SizedBox(width: 5,),
                        Text('${AppCubit.get(context).commentsCount[AppCubit.get(context).postsId[index]]} comments'),
                      ],),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[200],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.userPhoto),
                  radius: 15,
                ),
                SizedBox(width: 15,),
                Expanded(child: InkWell(
                    onTap:(){
                      AppCubit.get(context).getComments(AppCubit.get(context).postsId[index]);
                      navigateTo(context,CommentScreen(postId: AppCubit.get(context).postsId[index],));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('write a comment ....',
                        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16),
                      ),
                    )
                )
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: Container(
                    height: 34,
                    child: InkWell(
                      onTap: (){
                        AppCubit.get(context).likePost(AppCubit.get(context).postsId[index]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Icon(AppCubit.get(context).isLikedList[AppCubit.get(context).postsId[index]] ? Icons.favorite_outlined : Icons.favorite_outline ,color: Colors.red,),
                        SizedBox(width: 5,),
                        Text('Like'),
                      ],),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}