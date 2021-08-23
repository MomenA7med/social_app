import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/m_storage.dart';
import 'package:social_app/view_model/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login(String email,String password){
    emit(LoginLoadingState());
    FirebaseAuth.
    instance.
    signInWithEmailAndPassword(email: email, password: password).
    then((value) {
      mStorage.setToken('token', value.user.uid);
      emit(LoginSuccessState());
    }).
    onError((error, stackTrace) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

}