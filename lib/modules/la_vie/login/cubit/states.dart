import '../../../../models/userData/UserModel.dart';

abstract class LaVieLoginStates {}

class LaVieLoginInitialState extends LaVieLoginStates {}

class LaVieLoginLoadingState extends LaVieLoginStates {}

class LaVieLoginSuccessState extends LaVieLoginStates
{
  final UserData user;

  LaVieLoginSuccessState(this.user);

}

class LaVieLoginErrorState extends LaVieLoginStates
{
  final String error;

  LaVieLoginErrorState(this.error);
}

class LaVieChangePasswordVisibilityState extends LaVieLoginStates {}
class LaVieChangeEnteranceLayoutState extends LaVieLoginStates {}



class LaVieSignUpLoadingState extends LaVieLoginStates {}
class LaVieSignUpSuccessState extends LaVieLoginStates {
  final UserData user;

  LaVieSignUpSuccessState(this.user);

}
class LaVieSignUpErrorState extends LaVieLoginStates
{
  final String error;

  LaVieSignUpErrorState(this.error);
}