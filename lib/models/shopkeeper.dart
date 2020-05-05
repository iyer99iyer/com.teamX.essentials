import 'package:cloud_firestore/cloud_firestore.dart';

class ShopKeeper {
  final String shopName;
  final String email;
  final String number;
  final List<dynamic> shopType;
  final GeoPoint location;
  final String name;
  final String docId;
  final String storeStatus;

  ShopKeeper({
    this.docId,
    this.shopName,
    this.email,
    this.number,
    this.shopType,
    this.location,
    this.name,
    this.storeStatus,
  });
}
