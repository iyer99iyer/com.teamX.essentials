import 'package:essentials/models/user.dart';
import 'package:essentials/screens/google_maps.dart';
import 'package:essentials/screens/maps.dart';
import 'package:essentials/screens/shopkeper_screens/new_vendor.dart';
import 'package:essentials/screens/shopkeper_screens/s_authentication.dart';
import 'package:essentials/screens/shopkeper_screens/shopkeeper_login.dart';
import 'package:essentials/screens/shopkeper_screens/shopkeeper_signup.dart';
import 'package:essentials/screens/shopkeper_screens/vendor_dashboard.dart';
import 'package:essentials/screens/user_screens/u_authentication.dart';
import 'package:essentials/screens/user_screens/user_dashboard.dart';
import 'package:essentials/screens/user_screens/user_login.dart';
import 'package:essentials/screens/welcome.dart';
import 'package:essentials/services/auth.dart';
import 'package:essentials/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Wrapper(),
      ),
    );
  }
}
