import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/constants.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';

class ItemsList extends StatefulWidget {
  final Function(String, bool) getSelectedItems;

  const ItemsList({Key key, this.getSelectedItems}) : super(key: key);

  @override
  _ItemsListState createState() => _ItemsListState();
}

//List<ItemModel> list = [
//  ItemModel(
//    docId: 'DMWkogG3mCmpfzMNPmfJ',
//    imageUrl:
//        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
//    itemName: 'rice',
//  ),
//  ItemModel(
//    docId: 'DMWkogG3mCmpfzMNPmfJ',
//    imageUrl:
//        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
//    itemName: 'rice',
//  ),
//  ItemModel(
//    docId: 'DMWkogG3mCmpfzMNPmfJ',
//    imageUrl:
//        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
//    itemName: 'rice',
//  ),
//  ItemModel(
//    docId: 'DMWkogG3mCmpfzMNPmfJ',
//    imageUrl:
//        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
//    itemName: 'rice',
//  ),
//  ItemModel(
//    docId: 'DMWkogG3mCmpfzMNPmfJ',
//    imageUrl:
//        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
//    itemName: 'rice',
//  ),
//];

List<bool> checked = [];

bool status = false;

QuerySnapshot snapshot;

class _ItemsListState extends State<ItemsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaticList();
  }

  getStaticList() async {
    setState(() {
      status = true;
    });
    snapshot = await Firestore.instance.collection('Grocery').getDocuments();
    getBool(snapshot.documents.length);

    setState(() {
      status = false;
    });
  }

  getBool(int len) {
    checked.clear();
    for (int i = 0; i < len; i++) {
      checked.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return status
        ? Container(
            decoration: kGradientBoxDecoration,
            height: 500,
            child: Loading(),
          )
        : ListView.builder(
            itemCount: snapshot.documents.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(12),
                child: ListTile(
                  title: Text(
                    snapshot.documents[index].data['Item-name']
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        snapshot.documents[index].data['Item-img-url']),
                  ),
                  trailing: Checkbox(
                    value: checked[index],
                    onChanged: (v) {
                      widget.getSelectedItems(
                          snapshot.documents[index].data['Doc_id'], v);
                      setState(
                        () {
                          checked[index] = v;
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
  }
}
