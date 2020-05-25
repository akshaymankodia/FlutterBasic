import 'dart:async';
import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:basic_app/bloc/login_bloc/login_state.dart';
import 'package:basic_app/bloc/login_bloc/login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuthRepository _firebaseAuthRepository;

  LoginBloc({
    @required FirebaseAuthRepository firebaseAuthRepository,
  })  : assert(firebaseAuthRepository != null),
        _firebaseAuthRepository = firebaseAuthRepository;

  @override
  LoginState get initialState => LoginState.initial();

 

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
   if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _firebaseAuthRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
