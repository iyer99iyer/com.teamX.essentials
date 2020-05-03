import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/user.dart';
import 'package:essentials/screens/shopkeper_screens/vendor_dashboard.dart';
import 'package:essentials/screens/user_screens/user_dashboard.dart';
import 'package:essentials/services/auth.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final User user;

  const Dashboard({Key key, @required this.user}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();

  String auth;
  bool status = false;

  static String userid = 'iyervivek199@gmail.com';

  getSomeStuff() async {
    var result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.user.emailId)
        .getDocuments();

    if (result.documents[0].exists) {
      setState(() {
        auth = result.documents[0].data['type'];

        status = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSomeStuff();
  }

  @override
  Widget build(BuildContext context) {
    return status
        ? auth == 'user' ? UserDashboard() : VendorDashboard()
        : Loading();
  }
}
