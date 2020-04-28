import 'package:essentials/screens/user_screens/user_login.dart';
import 'package:essentials/screens/user_screens/user_signup.dart';
import 'package:flutter/material.dart';

class UserAuthentication extends StatefulWidget {
  @override
  _UserAuthenticationState createState() => _UserAuthenticationState();
}

class _UserAuthenticationState extends State<UserAuthentication> {
  bool showSignIn = true;

  void toogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? UserLogin(toogleView: toogleView)
        : UserSignUp(toogleView: toogleView);
  }
}
