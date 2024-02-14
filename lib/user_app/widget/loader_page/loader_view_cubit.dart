import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../domain/api_client/auth_api_client.dart';
import '../../domain/blocs/auth_bloc/auth_bloc.dart';
import '../../domain/blocs/auth_bloc/auth_state.dart';
import '../../domain/data_provider/session_data_provider.dart';

enum LoaderViewCubitState { unknown, authorized, unAuthorized }

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final sessionDataProvider = SessionDataProvider();
  final authBloc = AuthBloc();
  late final StreamSubscription<AuthBlocState> authBlocSubscription;

  // late final String sessionId;

  LoaderViewCubit() : super(LoaderViewCubitState.unknown) {
    Future.microtask(() {
      onState();
      // emitState();
    });
  }

  void emitState(LoaderViewCubitState state) async {
    // print(LoaderViewCubitState);
    final session = await sessionDataProvider.getSessionId();
    if (session == null) {
      if (state == LoaderViewCubitState.unknown) {
        emit(LoaderViewCubitState.unAuthorized);
      } else {
        emit(LoaderViewCubitState.unknown);
      }
    } else {
      emit(LoaderViewCubitState.authorized);
    }
  }

  void onState() async {
    final user = await AuthApiClient().getToken();
    if (user == null) {
      emit(LoaderViewCubitState.unAuthorized);
    } else if (user != null) {
      emit(LoaderViewCubitState.authorized);
    }
  }

  void onUnAuthorized() {
    emit(LoaderViewCubitState.unAuthorized);
  }
  void onUnknown() {
    emit(LoaderViewCubitState.unknown);
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
