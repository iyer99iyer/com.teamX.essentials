import 'package:essentials/screens/shopkeper_screens/shopkeeper_login.dart';
import 'package:essentials/screens/shopkeper_screens/shopkeeper_signup.dart';
import 'package:flutter/material.dart';

class ShopAuthentication extends StatefulWidget {
  @override
  _ShopAuthenticationState createState() => _ShopAuthenticationState();
}

class _ShopAuthenticationState extends State<ShopAuthentication> {
  bool showSignIn = true;

  void toogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? ShopkeeperLogin(
            toogleView: toogleView,
          )
        : ShopkeeperSignUp(
            toogleView: toogleView,
          );
  }
}
