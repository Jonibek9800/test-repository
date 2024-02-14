import 'package:bloc/bloc.dart';

enum AuthViewCubitState {login, registration}

class AuthViewCubit extends Cubit<AuthViewCubitState> {
  AuthViewCubit() : super (AuthViewCubitState.login);

  void onLoginState () {
    emit(AuthViewCubitState.login);
  }

  void onRegistrationState () {
    emit(AuthViewCubitState.registration);
  }
}