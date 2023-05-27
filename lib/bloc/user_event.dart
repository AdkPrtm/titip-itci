part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUser extends UserEvent {
  final String email;
  LoadUser(this.email);
}

class SignInUser extends UserEvent {
  final String? email, password;
  final UserModel? userModel;

  SignInUser({this.email, this.password, this.userModel});
}

class SignOutUser extends UserEvent {}
