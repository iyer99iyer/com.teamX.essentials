import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/user.dart';
import 'package:essentials/screens/shopkeper_screens/vendor_dashboard.dart';
import 'package:essentials/screens/user_screens/user_dashboard.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final User user;

  const Dashboard({Key key, @required this.user}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String auth;
  bool status = false;

  static String userid = 'iyervivek1999@teamX.com';

  getSomeStuff() async {
    try {
      print(
          'cloud email and iyervivek1999@teamX.com = ${widget.user.emailId == userid}');
      print('yo from dashborad : ${widget.user.emailId}');
      var result = await Firestore.instance
          .collection('users')
          .where('email', isEqualTo: widget.user.emailId)
          .getDocuments();

      print(result.documents);

      if (result.documents[0].exists) {
        setState(() {
          auth = result.documents[0].data['type'];
          print('yo from dashborad');
          status = true;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getSomeStuff();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return status
        ? auth == 'user'
            ? UserDashboard()
            : VendorDashboard(
                user: user,
              )
        : Loading();
  }
}
