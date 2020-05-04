import 'dart:ui';

import 'package:essentials/screens/google_maps.dart';
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
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'LIST OF STORES',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF8B4F4F),
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
                              title: 'Medical Shops Near you',
                            )),
                  );
                },
                child: CustomTileWidget(
                  width: width,
                  path: 'assets/medical.png',
                  title: 'Medical',
                  subTitle: '“When the heart is at ease, the body is healthy”',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMaps(
                        shopType: 'veg',
                        title: 'Medical Shops Near you',
                      ),
                    ),
                  );
                },
                child: CustomTileWidget(
                  width: width,
                  path: 'assets/vegetables.jpg',
                  title: 'Vegetables',
                  subTitle: '“Vegetables deplete soil”',
                ),
              ),
              GestureDetector(
                child: CustomTileWidget(
                  width: width,
                  path: 'assets/grocery.jpg',
                  title: 'Grocery',
                  subTitle: '“I like my freedom”',
                ),
              ),
              GestureDetector(
                child: CustomTileWidget(
                  width: width,
                  path: 'assets/dairy.jpg',
                  title: 'Dairy',
                  subTitle:
                      '“I\'m not a Twinkie lover. I don\'t do sugar or dairy either”',
                ),
              ),
              GestureDetector(
                child: CustomTileWidget(
                  width: width,
                  path: 'assets/bakery.jpg',
                  title: 'Bakeries',
                  subTitle: '“Nothing smells home like the smell of bakery”',
                ),
              )
            ],
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
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment
              .bottomCenter, // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xFF0277BD),
            const Color(0x000277BD)
          ], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      height: 100,
      width: width,
      child: Center(
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(path),
                  ),
                )),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: width * .5,
                  child: Text(
                    subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            )
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
