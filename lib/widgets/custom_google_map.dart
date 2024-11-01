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
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            //   northeast: const LatLng(31.071956147539264, 31.407605050179505),
            //   southwest: const LatLng(31.01365657287343, 31.348197604764987),
            // )),
            initialCameraPosition: initialCameraPosition),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              googleMapController.animateCamera(CameraUpdate.newLatLng(
                  const LatLng(30.971158992498815, 31.168489152001726)));
            },
            child: const Text('Change location'),
          ),
        )
      ],
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