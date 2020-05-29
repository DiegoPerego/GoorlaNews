import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final _key = GlobalKey<GoogleMapStateBase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        key: _key,
        initialZoom: 12,
        initialPosition: GeoCoord(34, -118),
        mapType: MapType.roadmap,
        interactive: true,
        markers: {Marker(GeoCoord(34, -118))},
      ),
    );
  }
}
