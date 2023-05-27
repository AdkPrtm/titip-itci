import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:titip_itci/models/models.dart';
import 'package:titip_itci/service/service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SignInUser>((event, emit) async {
      emit(UserLoading());
      if (event.email != null) {
        ResultSignIn userModel =
            await AuthService().signInUser(event.email!, event.password!);
        if (userModel.userModel != null) {
          emit(UserSuccess(userModel.userModel));
        } else {
          emit(UserFailed(userModel.msg));
        }
      } else {
        emit(UserSuccess(event.userModel));
      }
    });
  }
}
