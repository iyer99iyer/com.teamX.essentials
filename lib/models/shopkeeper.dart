import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopKeeper {
  final String shopName;
  final String email;
  final String number;
  final List<dynamic> shopType;
  final GeoPoint location;
  final String name;

  ShopKeeper({
    this.shopName,
    this.email,
    this.number,
    this.shopType,
    this.location,
    this.name,
  });
}
