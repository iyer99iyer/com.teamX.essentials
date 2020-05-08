import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemsInStoreList extends StatefulWidget {
  final String docID;

  const ItemsInStoreList({Key key, @required this.docID}) : super(key: key);

  @override
  _ItemsInStoreListState createState() => _ItemsInStoreListState();
}

class _ItemsInStoreListState extends State<ItemsInStoreList> {
  bool status = false;

  List<ItemModel> itemModels = [];
//  String docID = 'AEmq07YnsLNhko4XpClt';
  List<dynamic> itemDocIds;

  @override
  void initState() {
    super.initState();
    print('i am in init');
    getItemList();
  }

  getItemList() async {
    status = false;
    itemModels.clear();
    print('i am in getItem');
    await Firestore.instance
        .collection('shops')
        .document(widget.docID)
        .get()
        .then((value) {
      setState(() {
        itemDocIds = value.data['itemList'];
      });
    });
    await getDocData(itemDocIds);
  }

  Future getDocData(List<dynamic> docIds) async {
    print('i am in getDocData');
    for (String docId in docIds) {
      print('i am in loop');
      await Firestore.instance
          .collection('Grocery')
          .document(docId)
          .get()
          .then((doc) {
        if (doc.exists) {
          itemModels.add(ItemModel(
            imageUrl: doc.data['Item-img-url'],
            itemName: doc.data['Item-name'],
            docId: doc.documentID,
          ));
        } else {
          print(docId);
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
        ? itemModels.length != 0
            ? ListView.builder(
                itemCount: itemModels.length,
                itemBuilder: (context, index) {
                  print(itemModels.length);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Color(0x22FFFFFF),
                        height: 70,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        itemModels[index].imageUrl)),
                              ),
                            ),
                          ),
                          title: Text(
                            itemModels[index].itemName.toUpperCase(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(
                height: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Try Adding Items from the',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
        : Center(child: Text('loading...'));
  }

  _removeFromFirestoreCurrentList(String id) async {
    List<dynamic> removeIDList = [];
    removeIDList.add(id);

    await Firestore.instance
        .collection('shops')
        .document(widget.docID)
        .updateData({
      'itemList': FieldValue.arrayRemove(removeIDList),
    }).catchError((e) => print(e));

    print('$id this document was removed');
  }
}
