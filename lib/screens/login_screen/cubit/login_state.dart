abstract class LoginStates{}
class LoginInitState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}
class GetUserSuccessState extends LoginStates{}
class GetUserErrorState extends LoginStates{}

class ChangeLoginEyeState extends LoginStates{}