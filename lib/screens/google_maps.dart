// key = AIzaSyCDoY1h9Paae93OdPcQehjponIjHl6Ja-c;
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key key, @required this.shopType, @required this.title})
      : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();

  final String shopType;
  final String title;
}

class _GoogleMapsState extends State<GoogleMaps> {
  BitmapDescriptor pinLocationIcon;
  List<Marker> allMarkers = [];

  GoogleMapController _mapController;

  bool mapToggle = false;

  Position currentLocation;

  var vegShops = [];

  @override
  void initState() {
    super.initState();

    getMarkerStyle();

    getInitialLocation();
  }

  getMarkerStyle() async {
    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 3), 'assets/pin_icon.png')
        .then((onValue) {
      setState(() {
        pinLocationIcon = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Vegetable Shop',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: mapToggle
            ? Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .91,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: 14,
                          ),
                          markers: Set.from(allMarkers),
                          onMapCreated: mapCreated,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(8),
                          child: IconButton(
                              icon: Icon(Icons.my_location),
                              onPressed: () {
                                getCurrentLocation();
                              }),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          elevation: 10,
                          color: Colors.green,
                          child: Text('vegetable shops'),
                        ),
                      )
                    ],
                  ),
                ],
              )
            : Loading());
  }

  void mapCreated(controller) {
    setState(() {
      _mapController = controller;
    });
  }

  getInitialLocation() async {
    await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((curLocation) {
      setState(() {
        currentLocation = curLocation;
        mapToggle = true;
      });
    });
    addMarkerForCurrentLocation();
  }

  getCurrentLocation() {
    moveToLcoation(currentLocation);
  }

  addMarkerForCurrentLocation() async {
    print('All Markers lenght : ${allMarkers.length}');

    allMarkers.add(
      Marker(
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), 'assets/pin_icon.png',
            mipmaps: true),
        markerId: MarkerId("myMarker"),
        infoWindow: InfoWindow(title: 'Your Location'),
        draggable: false,
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
      ),
    );
    addShops();
  }

  addShops() {
    vegShops = [];
    Firestore.instance.collection(widget.shopType).getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        if (allMarkers.length > 1) {
          allMarkers.removeRange(1, allMarkers.length);
        }
        for (var i = 0; i < docs.documents.length; i++) {
          vegShops.add(docs.documents[i].data);
          createMarker(docs.documents[i].data);
        }
      }
    });
  }

  createMarker(shop) {
    setState(() {
      allMarkers.add(
        Marker(
          markerId: MarkerId(
            shop['shop_name'],
          ),
          infoWindow: InfoWindow(title: shop['shop_name']),
          position:
              LatLng(shop['location'].latitude, shop['location'].longitude),
        ),
      );
    });
  }

  moveToLcoation(Position position) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16,
        ),
      ),
    );
  }
}
