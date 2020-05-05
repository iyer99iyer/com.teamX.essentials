import 'package:cloud_firestore/cloud_firestore.dart';

class ShopLocation {
  final String shopName;
  final GeoPoint location;
  final String docId;

  ShopLocation(this.shopName, this.location, this.docId);
}

