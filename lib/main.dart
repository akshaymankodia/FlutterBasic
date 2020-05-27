// import 'package:basic_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:basic_app/screens/Home.dart';
import 'package:basic_app/screens/Login.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authentication_bloc/authentication_bloc_barrel.dart';
import 'bloc/simple_bloc_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final FirebaseAuthRepository firebaseAuthRepository = FirebaseAuthRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        firebaseAuthRepository: firebaseAuthRepository,
      )..add(AuthenticationStarted()),
      child: Basics(firebaseAuthRepository : firebaseAuthRepository),
    ),
  );
}

class Basics extends StatelessWidget {
  final FirebaseAuthRepository _firebaseAuthRepository;

  Basics({Key key, @required FirebaseAuthRepository firebaseAuthRepository})
    : assert(firebaseAuthRepository != null),
      _firebaseAuthRepository = firebaseAuthRepository,
      super(key : key);
      

  static const _title = "Basic App";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
        builder: (context, state) {
          if(state is AuthenticationSuccess){
            return HomePage(name : state.displayName, firebaseAuthRepository: _firebaseAuthRepository,);
          }
          if(state is AuthenticationFailure){
            return LoginScreen(firebaseAuthRepository: _firebaseAuthRepository,);
          }
          return LoginScreen(firebaseAuthRepository: _firebaseAuthRepository,);
        },
      )
    );
  }
}


