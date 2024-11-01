import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng position;
  PlaceModel({required this.id, required this.name, required this.position});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'MET Higher Institute',
    position: const LatLng(31.016272261089693, 31.37863367256164),
  ),
  PlaceModel(
    id: 2,
    name: 'Mansoura University',
    position: const LatLng(31.045074115759814, 31.35430897570595),
  ),
  PlaceModel(
    id: 3,
    name: 'Buffalo Burger',
    position: const LatLng(31.034743754136493, 31.35858968549748),
  ),
  PlaceModel(
    id: 4,
    name: 'LampaTronics',
    position: const LatLng(31.04062064863887, 31.36612841971891),
  ),
];
