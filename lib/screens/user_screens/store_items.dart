import 'package:essentials/constants.dart';
import 'package:essentials/screens/user_screens/items_in_store_list.dart';
import 'package:flutter/material.dart';

class StoreItems extends StatefulWidget {
  final String docID;

  const StoreItems({Key key, @required this.docID}) : super(key: key);

  @override
  _StoreItemsState createState() => _StoreItemsState();
}

class _StoreItemsState extends State<StoreItems> {
  AppBar appBar = AppBar(
    title: Text('Esentials List'),
  );

  @override
  Widget build(BuildContext context) {
    double appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Container(
                decoration: kGradientBoxDecoration,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'List of items',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .848 -
                          appBarHeight,
                      child: ItemsInStoreList(docID: widget.docID),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
