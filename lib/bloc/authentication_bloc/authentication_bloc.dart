import 'dart:async';
import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationBlocEvent, AuthenticationBlocState> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  AuthenticationBloc({@required FirebaseAuthRepository firebaseAuthRepository})
    : assert(firebaseAuthRepository != null),
      _firebaseAuthRepository = firebaseAuthRepository;

  @override
  AuthenticationBlocState get initialState => AuthenticationBlocInitial();

  @override
  Stream<AuthenticationBlocState> mapEventToState(
    AuthenticationBlocEvent event,
  ) async* {
    if (event is AuthenticationStarted){
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn){
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut){
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationBlocState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _firebaseAuthRepository.isSignedIn();
    if(isSignedIn){
      final name = await _firebaseAuthRepository.getUser();
      yield AuthenticationSuccess(name);
    }else{
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationBlocState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await _firebaseAuthRepository.getUser());
  }

  Stream<AuthenticationBlocState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _firebaseAuthRepository.signOut();
  }
}