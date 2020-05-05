import 'package:flutter/material.dart';

class StoreItems extends StatefulWidget {
  @override
  _StoreItemsState createState() => _StoreItemsState();
}

class _StoreItemsState extends State<StoreItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text('List of items'),
            SizedBox(
              height: 20,
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
