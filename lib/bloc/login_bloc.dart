import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbc_test/bloc/common_bloc.dart';

class LoginBloc extends Bloc<MainEvent, MainState> {
  LoginBloc() : super(StateInitialzed()) {
    on<GetAuthEvent>(_onGetAuth);
  }

  void _onGetAuth(GetAuthEvent event, Emitter<MainState> emit) async {
    emit(StateLoading());

    try {
      final auth = await FireBaseAuth.signInWithEmailPassword();
      if (auth) {
        emit(GetAuthStateSuccess(success: 'Login Successfully'));
      } else {
        emit(StateError(message: 'signInWithEmailPassword == false'));
      }
    } on Exception {
      emit(StateError(message: 'something went wrong'));
    } catch (e) {
      emit(StateError(message: e.toString()));
    }
  }
}

class FireBaseAuth {
  static Future<bool> signInWithEmailPassword() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    return true;
  }
}

class GetAuthEvent extends MainEvent {
  final String email;
  final String password;
  GetAuthEvent({required this.email, required this.password});
}

class GetAuthStateSuccess extends MainState {
  final String success;

  GetAuthStateSuccess({required this.success});
}
