import 'package:essentials/services/auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlatButton(
        onPressed: () {
          _auth.signout();
        },
        color: Colors.blueAccent,
        child: Text('Logout'),
      )),
    );
  }
}
