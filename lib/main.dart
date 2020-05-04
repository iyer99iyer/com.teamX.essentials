import 'package:essentials/models/user.dart';
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
          // primarySwatch: Color(0xFF01579B),
          accentColor: Color(0xFF01579B),
        ),
        home: Wrapper(),
      ),
    );
  }
}
