import 'package:flutter/material.dart';
import 'package:maps_app/widgets/custom_google_map.dart';

void main() {
  runApp(const GoogleMapsTest());
}

class GoogleMapsTest extends StatelessWidget {
  const GoogleMapsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMap(),
    );
  }
}
