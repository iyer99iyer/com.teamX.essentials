import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

List<ItemModel> list = [
  ItemModel(
    docId: 'DMWkogG3mCmpfzMNPmfJ',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
    itemName: 'rice',
  ),
  ItemModel(
    docId: 'DMWkogG3mCmpfzMNPmfJ',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
    itemName: 'rice',
  ),
  ItemModel(
    docId: 'DMWkogG3mCmpfzMNPmfJ',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
    itemName: 'rice',
  ),
  ItemModel(
    docId: 'DMWkogG3mCmpfzMNPmfJ',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
    itemName: 'rice',
  ),
  ItemModel(
    docId: 'DMWkogG3mCmpfzMNPmfJ',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/xteam-e679e.appspot.com/o/rice.jpg?alt=media&token=851b59a2-aa23-4f3d-a950-6b8e115e5d03',
    itemName: 'rice',
  ),
];

List<bool> checked = List();

class _ItemsListState extends State<ItemsList> {
  getBool(int len) {
    for (int i = 0; i < len; i++) {
      checked.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Grocery').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading data please wait...');
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            getBool(snapshot.data.documents.length);
            return Container(
              margin: EdgeInsets.all(12),
              child: ListTile(
                title: Text(
                  snapshot.data.documents[index]['Item-name']
                      .toString()
                      .toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      snapshot.data.documents[index]['Item-img-url']),
                ),
                trailing: Checkbox(
                    value: checked[index],
                    onChanged: (v) {
                      setState(() {
                        checked[index] = v;
                      });
                    }),
              ),
            );
          },
        );
      },
    );
  }
}
