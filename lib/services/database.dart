import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/shopkeeper.dart';
import 'package:essentials/models/user.dart';

class DatabaseServices {
  final User user;

  DatabaseServices({this.user});

  // collection refference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference skeyCollection =
      Firestore.instance.collection('skey');
  final CollectionReference shopCollection =
      Firestore.instance.collection('shops');

  Future updateUserData(
      {String name,
      String email,
      String uid,
      double locationLat,
      double locationLng}) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'name': name,
      'type': 'user',
    }).catchError((e) {
      print(e);
    });
  }

  Future updateVendorData(
      {String name,
      String email,
      String uid,
      double locationLat,
      double locationLng}) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'name': name,
      'type': 'shop',
    }).catchError((e) {
      print(e);
    });
  }

  Future updateShopData(
      {String shopName,
      String email,
      String number,
      List<String> shopType,
      GeoPoint location,
      String name}) async {
    await shopCollection.document().setData({
      'email': email,
      'shopName': shopName,
      'shopType': shopType,
      'location': location,
      'number': number,
      'name': name,
      'storeStatus': 'closed',
    }).catchError((onError) {
      print(onError);
    });
  }

  ShopKeeper _shopKeeperFromShops(QuerySnapshot docs) {
    print(docs.documents[0].data['shopName']);

    return docs != null
        ? ShopKeeper(
            shopName: docs.documents[0].data['shopName'],
            email: docs.documents[0].data['email'],
            number: docs.documents[0].data['number'],
            shopType: docs.documents[0].data['shopType'],
            location: docs.documents[0].data['location'],
            name: docs.documents[0].data['name'],
            docId: docs.documents[0].documentID,
            storeStatus: docs.documents[0].data['storeStatus'],
          )
        : null;
  }

  Future<ShopKeeper> getShopData(String email) async {
    try {
      QuerySnapshot docs =
          await shopCollection.where('email', isEqualTo: email).getDocuments();
      //     .then((docs) {
      //   print(docs.documents[0].data['shopName']);
      //   return _shopKeeperFromShops(docs);
      // });
      print(docs);
      if (docs.documents[0].exists) {
        return _shopKeeperFromShops(docs);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ShopKeeper> getShopDataWithDocId(String docId) async {
    try {
      ShopKeeper shopKeeper;
      await shopCollection.document(docId).get().then((onValue) {
        if (onValue.exists) {
          shopKeeper = ShopKeeper(
            storeStatus: 'closed',
            docId: onValue.documentID,
            email: onValue.data['email'],
            location: onValue.data['location'],
            name: onValue.data['name'],
            number: onValue.data['number'],
            shopName: onValue.data['shopName'],
            shopType: onValue.data['shopType'],
          );
        } else {
          print('Error in retriving data or converting');
          shopKeeper = null;
        }
      });
      return shopKeeper;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> getVenderAutherisation(String email) async {
    bool value = false;

    await userCollection
        .where('email', isEqualTo: email)
        .getDocuments()
        .then((docs) {
      if (docs.documents[0].exists) {
        print(docs.documents[0].data['type']);
        if (docs.documents[0].data['type'] == 'shop') {
          value = true;
        }
      } else {
        value = false;
      }
    }).catchError((onError) {
      print(onError);
    });
    return value;
  }

  Future<bool> getUserAutherisation(String email) async {
    bool value = false;

    await userCollection
        .where('email', isEqualTo: email)
        .getDocuments()
        .then((docs) {
      if (docs.documents[0].exists) {
        print(docs.documents[0].data['type']);
        if (docs.documents[0].data['type'] == 'user') {
          value = true;
        }
      } else {
        value = false;
      }
    }).catchError((onError) {
      print(onError);
    });
    return value;
  }

  Future<bool> validateKey(String skey) async {
    bool result = false;

    await skeyCollection
        .where('key', isEqualTo: skey)
        .getDocuments()
        .then((docs) {
      if (docs.documents[0].exists) {
        result = true;
      } else {
        result = false;
      }
    }).catchError((onError) {
      print(onError);
    });
    return result;
  }
}
