import 'dart:ui';

import 'package:essentials/constants.dart';
import 'package:essentials/screens/shopkeper_screens/s_authentication.dart';
import 'package:essentials/screens/user_screens/u_authentication.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final ImageProvider logo = AssetImage(
    "assets/logo1.png",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kGradientBoxDecoration,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * .25,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .32,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: logo,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                // child: BackdropFilter(
                //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                //   child: new Container(
                //     decoration:
                //         new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                //   ),
                // ),
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(child: Text('')),
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
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                              child: Text(
                            'User Login',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          )),
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
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Vendor Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
