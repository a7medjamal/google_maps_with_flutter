// domain/entities/poi_entity.dart

class POIEntity {
  final int id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  POIEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });
}
