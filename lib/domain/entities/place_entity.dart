import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceEntity {
  final int id;
  final String name;
  final String description;
  final LatLng position;

  PlaceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.position,
  });
}
