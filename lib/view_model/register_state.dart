abstract class RegisterState{}

class RegisterInitialState extends RegisterState{}

class RegisterLoadingState extends RegisterState{}

class RegisterSuccessState extends RegisterState{}

class RegisterErrorState extends RegisterState{
  final String error;
  RegisterErrorState(this.error);
}
class RegisterCreateUserSuccessState extends RegisterState{}

class RegisterCreateUserErrorState extends RegisterState{
  final String error;
  RegisterCreateUserErrorState(this.error);
}