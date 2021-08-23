import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/m_storage.dart';
import 'package:social_app/view_model/register_state.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void register(String email,String password,String phone,String name){
    emit(RegisterLoadingState());
    FirebaseAuth.
    instance.
    createUserWithEmailAndPassword(email: email, password: password).
    then((value) {
      print(value.user.email);
      print(value.user.uid);
      mStorage.setToken('token', value.user.uid);
      emit(RegisterSuccessState());
      createUser(email, value.user.uid, phone, name);
    }).
    onError((error, stackTrace) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser(String email,String uId,String phone,String name){
    UserModel model = UserModel(name,phone,uId,email,'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png','https://i.pinimg.com/originals/30/5c/5a/305c5a457807ba421ed67495c93198d3.jpg','this is my bio');
    FirebaseFirestore.
    instance.
    collection('users').
    doc(uId).
    set(model.toMap()).
    then((value) {
      emit(RegisterCreateUserSuccessState());
    }).onError((error, stackTrace) {
      emit(RegisterCreateUserErrorState(error));
    });
  }

}
