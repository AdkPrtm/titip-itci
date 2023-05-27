part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {
}

class UserFailed extends UserState {
  final String? msg;
  UserFailed(this.msg);
}

class UserSuccess extends UserState {
  final UserModel? userModel;
  UserSuccess(this.userModel);
}
