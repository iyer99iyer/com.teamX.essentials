import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/constants.dart';
import 'package:essentials/screens/shopkeper_screens/get_current_items_list.dart';
import 'package:essentials/shared/items_list.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';

class CurrentItemList extends StatefulWidget {
  final String docID;

  const CurrentItemList({Key key, @required this.docID}) : super(key: key);

  @override
  _CurrentItemListState createState() => _CurrentItemListState();
}

//String docID = 'AEmq07YnsLNhko4XpClt';

List<String> docIdsToBeAddedToDatabase = [];

class _CurrentItemListState extends State<CurrentItemList> {
  List<String> documentIds = [];

  bool load = false;

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Current Items in Your Shop'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // TODO add bottom sheet here
                _addListFromBottomSheet();
              },
              child: Icon(Icons.add),
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: kGradientBoxDecoration,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      height: 500,
                      child: GetCurrentItemsList(
                        docID: widget.docID,
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  _addListFromBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF224058),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Add Your Items',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    height: 500,
                    child: ItemsList(
                      getSelectedItems: getCallBack,
                    ),
                  ),
                  MaterialButton(
                    color: Colors.green,
                    child: Text('Add These Item'),
                    onPressed: () async {
                      setState(() {
                        load = true;
                      });
                      print(
                          '$docIdsToBeAddedToDatabase is the list of items added to firestore');
                      Navigator.of(context).pop();
                      if (docIdsToBeAddedToDatabase != []) {
                        print('adding data to database');
                        await _addToFireStore(docIdsToBeAddedToDatabase);
//                        await getItemList();
                      }
                      docIdsToBeAddedToDatabase.clear();
                      setState(() {
                        load = false;
                      });
                    },
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  getCallBack(docId, selected) {
    if (selected) {
      print('$docId will be added');
      docIdsToBeAddedToDatabase.add(docId);
    } else {
      print('$docId will be deleted');
      docIdsToBeAddedToDatabase.remove(docId);
    }
  }

  _addToFireStore(docIdsToBeAddedToDatabase) async {
    if (docIdsToBeAddedToDatabase != []) {
      await Firestore.instance
          .collection('shops')
          .document(widget.docID)
          .updateData(
              {'itemList': FieldValue.arrayUnion(docIdsToBeAddedToDatabase)});
    }
  }
}
