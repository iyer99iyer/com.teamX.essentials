import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/models/user.dart';
import 'package:geolocation/geolocation.dart';

class DatabaseServices {
  final User user;

  DatabaseServices({this.user});

  // collection refference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference skeyCollection =
      Firestore.instance.collection('skey');

  Future updateUserData(
      {String name,
      String email,
      String uid,
      double locationLat,
      double locationLng}) async {
    return await userCollection.document(uid).setData({
      'email': email,
      'locationLat': locationLat,
      'locationLng': locationLng,
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
      'locationLat': locationLat,
      'locationLng': locationLng,
      'name': name,
      'type': 'shop',
    }).catchError((e) {
      print(e);
    });
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

    await skeyCollection.where('key', isEqualTo: skey).getDocuments().then((docs) {
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
