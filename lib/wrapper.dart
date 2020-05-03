import 'package:essentials/dashboard.dart';
import 'package:essentials/models/user.dart';
import 'package:essentials/screens/welcome.dart';
import 'package:essentials/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return wheater home or welcome widget

    final user = Provider.of<User>(context);

    if (user == null) {
      print(user);
      return Welcome();
    } else {
      print(user.emailId);

      return Dashboard(user: user);
    }
  }
}
