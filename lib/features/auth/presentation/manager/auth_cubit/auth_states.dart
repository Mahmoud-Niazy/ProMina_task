import '../../../data/models/user_model.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates{}

class UserLoginLoadingState extends AuthStates{}
class UserLoginSuccessfullyState extends AuthStates{
  final UserModel userData;
  UserLoginSuccessfullyState(this.userData);
}
class UserLoginErrorState extends AuthStates{
  final String error;
  UserLoginErrorState(this.error);
}