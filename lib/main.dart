import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const GoogleMapsTest());
}

class GoogleMapsTest extends StatefulWidget {
  const GoogleMapsTest({super.key});

  @override
  State<GoogleMapsTest> createState() => _GoogleMapsTestState();
}

class _GoogleMapsTestState extends State<GoogleMapsTest> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(31, 41)),
        ),
      ),
    );
  }
}
