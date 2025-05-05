// ignore_for_file: non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/placemodel.dart';

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
    initMarkers();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;
  Set<Marker> Markers = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            zoomControlsEnabled: false,
            markers: Markers,
            onMapCreated: (controller) {
              googleMapController = controller;
              initMapStyle();
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

  void initMapStyle() async {
    var DarkMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style/style.json');
    googleMapController.setMapStyle(DarkMapStyle);
  }

  // Future<Uint8List> getImageFromRawData(String image, double width) async {
  //   var imageData = await rootBundle.load(image);
  //   // convert Image to UintList
  //   var imageCodec = await ui.instantiateImageCodec(
  //       imageData.buffer.asUint8List(),
  //       targetWidth: width.round());
  //   // get the next edited frame (optional)
  //   var imageFrame = await imageCodec.getNextFrame();
  //   // convert it to its the raw datatype
  //   var imageByteData =
  //       await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
  //   return imageByteData!.buffer.asUint8List();
  // }

  void initMarkers() async {
    var customMarkerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/images/marker_icon.png');
    var myMarkers = places
        .map(
          (Placemodel) => Marker(
            icon: customMarkerIcon,
            infoWindow: InfoWindow(
              title: Placemodel.name,
            ),
            markerId: MarkerId(
              Placemodel.id.toString(),
            ),
            position: Placemodel.position,
          ),
        )
        .toSet();
    Markers.addAll(myMarkers);
    setState(() {});
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