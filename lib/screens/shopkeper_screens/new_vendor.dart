import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/user.dart';
import 'package:essentials/screens/shopkeper_screens/vendor_dashboard.dart';
import 'package:essentials/services/database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NewVendor extends StatefulWidget {
  final User user;

  const NewVendor({Key key, this.user}) : super(key: key);

  @override
  _NewVendorState createState() => _NewVendorState();
}

class _NewVendorState extends State<NewVendor> {
  bool loading = true;

  DatabaseServices _databaseServices = DatabaseServices();

  bool vselect = true;
  bool gselect = false;
  bool mselect = false;
  bool dselect = false;
  bool bselect = false;

  String shopName = '';
  String phoneNumber = '';

  GeoPoint location;
  Position position;

  String errorText = 'yo';

  final _formKey = GlobalKey<FormState>();

  String name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    getUserData();
  }

  getLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((onValue) {
      position = onValue;
    });
    location = GeoPoint(position.latitude, position.longitude);
    print(location);
    setState(() {
      loading = false;
    });
  }

  getUserData() async {
    await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.user.emailId)
        .getDocuments()
        .then((docs) {
      if (docs.documents[0].exists) {
        setState(() {
          name = docs.documents[0].data['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: loading
          ? Center(
              child: Text(
                'Getting location of the device ',
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Welcome ${name.toUpperCase()},',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Your Shop Name :',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          shopName = val;
                        },
                        validator: (val) =>
                            val.length < 4 ? 'enter atleast 4 char' : null,
                        autofocus: true,
                        textCapitalization: TextCapitalization.characters,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.blue,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Enter a name...',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          phoneNumber = val;
                        },
                        validator: (val) => val.length < 10
                            ? 'enter valid mobile number'
                            : null,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.blue,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Enter a phone number...',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Shop Type,',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        errorText,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(16),
                        color: Colors.grey[200],
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              vselect = !vselect;
                            });
                          },
                          leading: Icon(
                            Icons.shopping_basket,
                            size: 60,
                          ),
                          title: Text(
                            'Vegetable Shop',
                            style: TextStyle(fontSize: 24),
                          ),
                          selected: vselect,
                          enabled: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(16),
                        color: Colors.grey[200],
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              gselect = !gselect;
                            });
                          },
                          leading: Icon(
                            Icons.shopping_cart,
                            size: 60,
                          ),
                          title: Text(
                            'Grossary Shop',
                            style: TextStyle(fontSize: 24),
                          ),
                          selected: gselect,
                          enabled: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(16),
                        color: Colors.grey[200],
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              mselect = !mselect;
                            });
                          },
                          leading: Icon(
                            Icons.local_hospital,
                            size: 60,
                          ),
                          title: Text(
                            'Medical Shop',
                            style: TextStyle(fontSize: 24),
                          ),
                          selected: mselect,
                          enabled: true,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(16),
                        color: Colors.grey[200],
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              dselect = !dselect;
                            });
                          },
                          leading: Image(
                            image: NetworkImage(
                                'https://static.thenounproject.com/png/79356-200.png'),
                            color: dselect ? Colors.blue : Colors.black,
                          ),
                          title: Text(
                            'Diary Shop',
                            style: TextStyle(fontSize: 24),
                          ),
                          selected: dselect,
                          enabled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: MaterialButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            List<String> shopType = [];
            if (dselect || vselect || gselect || dselect || mselect) {
              setState(() {
                loading = true;
                errorText = '';
              });
              if (dselect) {
                shopType.add('dairy');
              }
              if (vselect) {
                shopType.add('veg');
              }
              if (gselect) {
                shopType.add('grocery');
              }
              if (mselect) {
                shopType.add('med');
              }

              print(shopType);

              var result = await _databaseServices.updateShopData(
                  email: widget.user.emailId,
                  shopName: shopName,
                  location: location,
                  number: phoneNumber,
                  shopType: shopType,
                  name : name);
              if (result == null) {
                setState(() {
                  loading = false;
                  errorText = 'Some error occured';
                });
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VendorDashboard(
                    user: widget.user,
                  ),
                ),
              );

              // if(bselect){
              //   shopType.add('dairy');
              // }
            } else {
              setState(() {
                errorText = 'Please select one type';
              });
              //
            }
          }
        },
        minWidth: screenWidth * .9,
        height: 55,
        color: Colors.blueAccent,
        elevation: 4.0,
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
