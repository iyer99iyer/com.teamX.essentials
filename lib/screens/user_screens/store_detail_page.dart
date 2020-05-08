import 'package:essentials/constants.dart';
import 'package:essentials/models/shopkeeper.dart';
import 'package:essentials/screens/user_screens/store_items.dart';
import 'package:essentials/services/database.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class StoreDetail extends StatefulWidget {
  final id;

  const StoreDetail({Key key, this.id}) : super(key: key);

  @override
  _StoreDetailState createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  final TextStyle kTextStyle = TextStyle(fontSize: 14);

  DatabaseServices _databaseServices = DatabaseServices();

  ShopKeeper shopKeeper;

  String shopType = '';

  List<Address> address;

  String doc = 'SEeADAMwpA2nVZfGKjab';
  bool status = false;

  @override
  void initState() {
    super.initState();

    print(widget.id.toString());

    getData();
  }

  getData() async {
    shopKeeper =
        await _databaseServices.getShopDataWithDocId(widget.id['doc_id']);
    if (shopKeeper != null) {
      int i = 0;
      for (String s in shopKeeper.shopType) {
        i += 1;

        if (s == 'veg') {
          shopType += 'Vegetable Shop,';
          if (i != (shopKeeper.shopType.length)) {
            shopType += '\n';
          }
        }
        if (s == 'dairy') {
          shopType += 'Dairy Shop,';
          if (i != (shopKeeper.shopType.length)) {
            shopType += '\n';
          }
        }
        if (s == 'med') {
          shopType += 'Medical Shop,';
          if (i != (shopKeeper.shopType.length)) {
            shopType += '\n';
          }
        }
        if (s == 'grocery') {
          shopType += 'Grocery Shop,';
          if (i != (shopKeeper.shopType.length)) {
            shopType += '\n';
          }
        }
        if (s == 'bakery') {
          shopType += 'Bakery Shop,';
          if (i != (shopKeeper.shopType.length)) {
            shopType += '\n';
          }
        }
        // if (i != (shopKeeper.shopType.length)) {
        //   shopType += '\n';
        // }
      }
      Geocoder.local
          // .google('AIzaSyCDoY1h9Paae93OdPcQehjponIjHl6Ja-c')
          .findAddressesFromCoordinates(
        Coordinates(
            shopKeeper.location.latitude, shopKeeper.location.longitude),
      )
          // Coordinates(22.7196, 75.8577))
          .then((onValue) {
        setState(() {
          status = true;
          address = onValue;
        });
      });
    } else {
      print(';${widget.id['doc_id']}');
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return status
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              //title: Text(widget.id['shop_name']),
              title: (shopKeeper != null)
                  ? Text(shopKeeper.shopName)
                  : Text('shop name was null'),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                    decoration: kGradientBoxDecoration,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              child: Image.asset('assets/grocery.jpg'),
                            ),
                          ),
                        ),
                        Divider(),
                        ShopKeeperDetailWidget(
                          kTextstyle: kTextStyle,
                          infoTitle: 'Shop Status',
                          infoAnswer: (shopKeeper != null)
                              ? shopKeeper.storeStatus.toUpperCase()
                              : 'null value',
                        ),
                        Divider(),
                        ShopKeeperDetailWidget(
                          kTextstyle: kTextStyle,
                          infoTitle: 'Shop Type',
                          infoAnswer: shopKeeper != null
                              ? shopType
                              : widget.id.toString(),
                        ),
                        Divider(),
                        ShopKeeperDetailWidget(
                          kTextstyle: kTextStyle,
                          infoTitle: 'Phone Number',
                          infoAnswer: shopKeeper != null
                              ? shopKeeper.number
                              : '9752078563',
                        ),
                        Divider(),
                        ShopKeeperDetailWidget(
                          kTextstyle: kTextStyle,
                          infoTitle: 'Address',
                          infoAnswer: (address != null)
                              ? address[0].addressLine
                              : 'error',
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreItems(
                                  docID: shopKeeper.docId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'List of Items Available',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 20),
                                  )
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
            ),
          )
        : Loading();
  }
}

class ShopKeeperDetailWidget extends StatelessWidget {
  const ShopKeeperDetailWidget({
    Key key,
    @required this.kTextstyle,
    this.infoTitle,
    this.infoAnswer,
  }) : super(key: key);

  final TextStyle kTextstyle;
  final String infoTitle;
  final String infoAnswer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
//        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            infoTitle,
            style: kTextstyle.copyWith(fontWeight: FontWeight.bold),
          ),
          // Text(
          //   ':',
          //   style: kTextstyle,
          // ),
          Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Text(
              infoAnswer,
              style: kTextstyle,
            ),
          )
        ],
      ),
    );
  }
}
