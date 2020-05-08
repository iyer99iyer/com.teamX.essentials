// key = AIzaSyCDoY1h9Paae93OdPcQehjponIjHl6Ja-c;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essentials/screens/user_screens/store_detail_page.dart';
import 'package:essentials/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    AppBar appBar = AppBar(
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
    double appBarSize = appBar.preferredSize.height;
    return Scaffold(
        appBar: appBar,
        body: mapToggle
            ? Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height -
                            appBarSize * 1.52,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: 14,
                          ),
                          markers: Set.from(allMarkers),
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: true,
                          onMapCreated: mapCreated,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 50,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xAAFFFFFF),
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
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          elevation: 10,
                          color: Colors.green,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Click on this ',
                                style: TextStyle(
                                    color: Colors.yellow, fontSize: 18),
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              Text(
                                'to continue...',
                                style: TextStyle(
                                    color: Colors.yellow, fontSize: 18),
                              ),
                            ],
                          ),
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
    //addShops();
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
        infoWindow: InfoWindow(
          title: 'Your Location',
        ),
        draggable: false,
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
      ),
    );
    addShops();
  }

  addShops() async {
    print(widget.shopType.toString());
    await Firestore.instance
        .collection(widget.shopType)
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        if (allMarkers.length > 1) {
          allMarkers.removeRange(1, allMarkers.length);
        }
        for (var i = 0; i < docs.documents.length; i++) {
          createMarker(docs.documents[i].data);
          print(docs.documents[i].data['shop_name']);
        }
      }
    });
  }

  createMarker(shop) async {
    double dist = await getDistance(
        LatLng(shop['location'].latitude, shop['location'].longitude));

    print(dist);

    setState(() {
      if (dist > 10 && dist < 3000) {
        allMarkers.add(
          Marker(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoreDetail(id: shop),
                ),
              );
            },
            markerId: MarkerId(
              shop['shop_name'],
            ),
            infoWindow: InfoWindow(title: shop['shop_name']),
            position:
                LatLng(shop['location'].latitude, shop['location'].longitude),
          ),
        );
      }
    });
  }

  getDistance(LatLng shopLocation) async {
    double dist = 400;

    await Geolocator()
        .distanceBetween(currentLocation.latitude, currentLocation.longitude,
            shopLocation.latitude, shopLocation.longitude)
        .then((onValue) {
      setState(() {
        print('from geolocator : ' + onValue.toString());
        dist = onValue;
      });
    });
    return dist;
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
