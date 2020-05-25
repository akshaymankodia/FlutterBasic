import 'package:basic_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:basic_app/bloc/login_bloc/login_bloc.dart';
import 'package:basic_app/bloc/login_bloc/login_event.dart';
import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:basic_app/bloc/login_bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuthRepository _firebaseAuthRepository;

  LoginScreen(
      {Key key, @required FirebaseAuthRepository firebaseAuthRepository})
      : assert(firebaseAuthRepository != null),
        _firebaseAuthRepository = firebaseAuthRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) =>
            LoginBloc(firebaseAuthRepository: _firebaseAuthRepository),
        child: LoginPage(firebaseAuthRepository: _firebaseAuthRepository),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key key, @required FirebaseAuthRepository firebaseAuthRepository})
      : assert(firebaseAuthRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            icon: Icon(FontAwesomeIcons.google, color: Colors.white),
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(
                LoginWithGooglePressed(),
              );
            },
            label: Text('Sign in with Google',
                style: TextStyle(color: Colors.white)),
            color: Colors.redAccent,
          );
        },
      ),
    );
  }
}
