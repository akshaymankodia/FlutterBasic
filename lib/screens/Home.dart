import 'package:basic_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:basic_app/repositories/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class Basics extends StatelessWidget {
//   static const _title = "Basic App";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: HomePage(),
//     );
//   }
// }

// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// final SnackBar snackBar = const SnackBar(content: Text('Showing Snackbar'));

class HomePage extends StatelessWidget {
  final FirebaseAuthRepository _firebaseAuthRepository;
  final String name;

  HomePage({Key key,@required this.name, @required FirebaseAuthRepository firebaseAuthRepository})
    : assert(firebaseAuthRepository != null),
      _firebaseAuthRepository = firebaseAuthRepository,
      super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Basics"),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () {
                //scaffoldKey.currentState.showSnackBar(snackBar);
              }),
          IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                openPage(context);
              }),
        ],
      ),
      body: Center(
        child: Text('Welcome $name'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedOut());
        },
        label: Text('Log Out'),
        icon: Icon(Icons.thumb_up),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Item 1'),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Page"),
      ),
      body:
          const Center(child: Text('New Page', style: TextStyle(fontSize: 22))),
    );
  }));
}
