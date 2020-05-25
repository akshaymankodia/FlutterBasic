part of 'authentication_bloc.dart';

abstract class AuthenticationBlocState extends Equatable {
  const AuthenticationBlocState();

  @override
  List<Object> get props => [];
}

class AuthenticationBlocInitial extends AuthenticationBlocState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccess extends AuthenticationBlocState {
  final String displayName;

  const AuthenticationSuccess(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Authenticated { displayName: $displayName }';
}

class AuthenticationFailure extends AuthenticationBlocState {}
