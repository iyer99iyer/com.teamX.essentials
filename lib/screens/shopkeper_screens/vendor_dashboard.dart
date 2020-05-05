import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/coming_soon.dart';
import 'package:essentials/models/shopkeeper.dart';
import 'package:essentials/models/user.dart';
import 'package:essentials/screens/shopkeper_screens/new_vendor.dart';
import 'package:essentials/services/auth.dart';
import 'package:essentials/services/database.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class VendorDashboard extends StatefulWidget {
  final User user;

  const VendorDashboard({Key key, this.user}) : super(key: key);

  @override
  _VendorDashboardState createState() => _VendorDashboardState();
}

final AuthService _auth = AuthService();

class _VendorDashboardState extends State<VendorDashboard> {
  DatabaseServices _databaseServices = DatabaseServices();

  ShopKeeper shopKeeper;

  bool status = false;
  bool shopStatus = false;
  bool loading = false;

  String storeStatus = 'open';

  // String name;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    shopKeeper = await _databaseServices.getShopData(widget.user.emailId);

    if (shopKeeper != null) {
      print(
          'adlsjfkjkafsdkjfjkfadsjafsdjkdfsajklfadsjkl ${shopKeeper.name},${shopKeeper.number},${shopKeeper.email}');
      setState(() {
        if (shopKeeper.storeStatus == 'open') {
          shopStatus = true;
        } else {
          shopStatus = false;
        }
      });
    }

    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return status
        ? shopKeeper != null
            ? Scaffold(
                appBar: AppBar(
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
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
                            child: Text('Logout',
                                style: TextStyle(color: Colors.white))),
                      ),
                    )
                  ],
                  backgroundColor: Colors.blue,
                  title: Text(
                    'Vendor Dashboard',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: GestureDetector(
                    child: Icon(Icons.menu, color: Colors.white),
                    onTap: () {},
                  ),
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.all(24),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${shopKeeper.shopName}',
                            style: TextStyle(
                                fontSize: 32, color: Colors.blueAccent),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '${shopKeeper.name}, You can manage your shop from here',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 24, color: Colors.black87),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Divider(
                            height: 40,
                            thickness: 2,
                          ),
                          Text(
                            'Manage the Shop Status',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 24, color: Colors.blueGrey),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  print(storeStatus);

                                  if (shopStatus) {
                                    storeStatus = 'closed';
                                  } else {
                                    storeStatus = 'open';
                                  }

                                  setState(() {
                                    status = false;
                                  });
                                  await Firestore.instance
                                      .collection('shops')
                                      .document(shopKeeper.docId)
                                      .updateData({'storeStatus': storeStatus});

                                  await Firestore.instance
                                      .collection('shops')
                                      .document(shopKeeper.docId)
                                      .get()
                                      .then((onValue) {
                                    setState(() {
                                      shopStatus = !shopStatus;
                                      storeStatus = onValue.data['storeStatus'];
                                      status = true;
                                    });
                                  });
                                },
                                child: status
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .4,
                                        decoration: BoxDecoration(
                                          //border: Border.all(color: Colors.blue, width: 4),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.power_settings_new,
                                              size: 150,
                                              color: shopStatus
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            Text(
                                              shopStatus ? 'Open' : 'Closed',
                                              style: TextStyle(
                                                  color: shopStatus
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: 40),
                                            )
                                          ],
                                        ),
                                      )
                                    : Center(
                                        child: Text('Please Wait'),
                                      ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 200,
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.blue, width: 4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage('assets/delivery.png'),
                                      fit: BoxFit.fitWidth,
                                      color: shopStatus
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      shopStatus ? 'Available' : '',
                                      style: TextStyle(
                                          color: shopStatus
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 30),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(
                            height: 40,
                            thickness: 2,
                          ),
                          Text(
                            'Manage Items',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 24, color: Colors.blueGrey),
                          ),
                          SizedBox(
                            height: 30,
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
                            child: Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.add,
                                        size: 60, color: Colors.black87),
                                    Text(
                                      'Edit items',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 30),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : NewVendor(
                user: widget.user,
              )
        : Loading();
  }
}
