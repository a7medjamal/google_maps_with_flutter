import 'package:maps_app/domain/entities/place_entity.dart';

abstract class MapRepository {
  // Method to fetch the list of POIs (Places of Interest)
  Future<List<PlaceEntity>> getPOIs();

  // Method to save a POI (Place of Interest)
  Future<bool> savePOI(PlaceEntity place);
}
