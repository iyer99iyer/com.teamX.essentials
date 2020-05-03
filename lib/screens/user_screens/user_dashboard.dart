import 'package:essentials/screens/google_maps.dart';
import 'package:essentials/screens/maps.dart';
import 'package:essentials/services/auth.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

final AuthService _auth = AuthService();

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _auth.signout();
              },
              child: Center(
                  child: Text('Logout', style: TextStyle(color: Colors.white))),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoogleMaps(
                          shopType: 'veg', title: 'Vegetable Shops Near you')),
                );
              },
              child: Container(
                height: 200,
                width: 200,
                color: Colors.green,
                child: Center(child: Text('Vegetable Shops Near me')),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GoogleMaps(
                            shopType: 'med',
                            title: 'Medical Shops Near you',
                          )),
                );
              },
              child: Container(
                height: 200,
                width: 200,
                color: Colors.green,
                child: Center(child: Text('Medical Shops Near me')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
