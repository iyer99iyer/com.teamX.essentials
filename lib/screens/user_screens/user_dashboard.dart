import 'dart:ui';

import 'package:essentials/coming_soon.dart';
import 'package:essentials/constants.dart';
import 'package:essentials/screens/google_maps.dart';
import 'package:essentials/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

final AuthService _auth = AuthService();

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: Colors.white,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
          size: 40,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                return Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Logout?",
                  desc: "Do you really want to logout?",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Confirm",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () {
                        _auth.signout();
                        Navigator.pop(context);
                      },
                      color: Colors.grey,
                    ),
                    DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
              },
              child: Center(
                  child: Text('Logout', style: TextStyle(color: Colors.white))),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'STORES NEAR YOUR LOCATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    color: Color(0xFF8B4F4F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(click on any of the following to continue...)',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMaps(
                          shopType: 'med',
                          title: 'Medical Shops near you',
                        ),
                      ),
                    );
                  },
                  child: CustomTileWidget(
                    width: width,
                    path: 'assets/med2.png',
                    title: 'Medical Stores',
                    subTitle: '',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMaps(
                          shopType: 'veg',
                          title: 'Vegetable Shops near you',
                        ),
                      ),
                    );
                  },
                  child: CustomTileWidget(
                    width: width,
                    path: 'assets/vegetables.jpg',
                    title: 'Vegetables Stores',
                    subTitle: '',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMaps(
                          shopType: 'gro',
                          title: 'Grosary Shops near you',
                        ),
                      ),
                    );
                  },
                  child: CustomTileWidget(
                    width: width,
                    path: 'assets/grocery.jpg',
                    title: 'Grocery Stores',
                    subTitle: '',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMaps(
                          shopType: 'dairy',
                          title: 'Dairy Shops near you',
                        ),
                      ),
                    );
                  },
                  child: CustomTileWidget(
                    width: width,
                    path: 'assets/dairy.jpg',
                    title: 'Dairy Products',
                    subTitle: '(Click Here)',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComingSoon(),
                      ),
                    );
                  },
                  child: CustomTileWidget(
                    width: width,
                    path: 'assets/bakery.jpg',
                    title: 'Bakeries',
                    subTitle: '',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTileWidget extends StatelessWidget {
  const CustomTileWidget({
    Key key,
    @required this.width,
    @required this.path,
    @required this.title,
    @required this.subTitle,
  }) : super(key: key);

  final double width;
  final String path;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    var sized = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * .015,
      ),
      decoration: kGradientBoxDecoration.copyWith(
        border: Border.all(
          color: Colors.blueGrey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 100,
      width: width * .9,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 100,
              width: sized.width * .25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage(path),
                  ),
                )),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: width * .5,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
//                Container(
//                  width: width * .4,
//                  child: Text(
//                    '',
//                    style: TextStyle(fontSize: 19, color: Colors.red),
//                  ),
//                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

//  ListTile(
//           subtitle: Text(
//             subTitle,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 15,
//             ),
//           ),
//           leading: Image(
//             width: 100,
//             height: 100,
//             image: AssetImage(path),
//           ),
//           title: Text(
//             title,
//             style: TextStyle(fontSize: 22, color: Colors.white),
//           ),
//         ),

// GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => GoogleMaps(
//                             shopType: 'med',
//                             title: 'Medical Shops Near you',
//                           )),
//                 );
//               },
//               child: Container(
//                 height: 200,
//                 width: 200,
//                 color: Colors.green,
//                 child: Center(child: Text('Medical Shops Near me')),
//               ),
//             )
