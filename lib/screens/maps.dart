import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => new _MapsState();
}

class _MapsState extends State<Maps> {
  MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FlutterMap(
        mapController: _mapController,
        options: new MapOptions(
            maxZoom: 17,
            center: new LatLng(22.7550967, 75.8653494),
            minZoom: 16.0),
        layers: [
          new TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/iyer99iyer/ck902oiiv0ddz1im4ne4tgpct/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaXllcjk5aXllciIsImEiOiJjazk0YWRjMXMwM25pM2VvYnJwNjA2bWR1In0.iOfGJtlsjFVXe2ZMOqJJBg",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiaXllcjk5aXllciIsImEiOiJjazk0YWRjMXMwM25pM2VvYnJwNjA2bWR1In0.iOfGJtlsjFVXe2ZMOqJJBg',
              'id': 'mapbox.mapbox-streets-v8'
            },
            maxZoom: 17,
            minZoom: 14,
          ),
          MarkerLayerOptions(markers: [
            Marker(
              width: 20,
              height: 20,
              point: LatLng(22.7550967, 75.8653494),
              builder: (context) => Container(
                child:
                    IconButton(icon: Icon(Icons.location_on), onPressed: () {}),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
