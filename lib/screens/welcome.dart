import 'package:essentials/screens/shopkeper_screens/s_authentication.dart';
import 'package:essentials/screens/user_screens/u_authentication.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              child: Center(child: Text('logo or some image')),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserAuthentication()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(child: Text('User Login')),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopAuthentication()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(child: Text('Vendor Login')),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
