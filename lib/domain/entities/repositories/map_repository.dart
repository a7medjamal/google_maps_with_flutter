import 'package:maps_app/domain/entities/place_entity.dart';

abstract class MapRepository {
  Future<List<PlaceEntity>> fetchPOIs();
  Future<bool> savePOI(PlaceEntity place);
}
