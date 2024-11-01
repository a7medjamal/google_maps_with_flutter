import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.040961319305158, 31.378490683910098),
      zoom: 15,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
    );
  }
}

// zoom levels
// world view: 0 -> 3
// country view: 4 -> 6
// city view:    10 -> 12
// street view:  13 -> 17
// shop/building view: 18 -> 20+
// 
// 