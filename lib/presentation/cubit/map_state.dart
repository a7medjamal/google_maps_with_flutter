import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/domain/entities/place_entity.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<PlaceEntity> pois;
  final bool isAddingPOI;
  final MapType currentMapType;

  MapLoaded({
    required this.pois,
    this.isAddingPOI = false,
    this.currentMapType = MapType.normal,
  });
}

class MapError extends MapState {
  final String message;

  MapError({required this.message});
}
