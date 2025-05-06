import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';

class GetPOIsUseCase {
  final MapRepository repository;

  GetPOIsUseCase(this.repository);

  // Returns a list of PlaceEntity instead of POIEntity
  Future<List<PlaceEntity>> execute() {
    return repository.getPOIs();
  }
}
