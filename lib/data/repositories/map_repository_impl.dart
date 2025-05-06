import 'package:maps_app/data/datasources/map_data_source.dart';
import 'package:maps_app/data/models/placemodel.dart';
import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRepositoryImpl implements MapRepository {
  final MapDataSource dataSource;

  MapRepositoryImpl({required this.dataSource});

  @override
  Future<List<PlaceEntity>> fetchPOIs() async {
    final placeModels = await dataSource.fetchPOIs();
    return placeModels.map((model) => _mapModelToEntity(model)).toList();
  }

  @override
  Future<bool> savePOI(PlaceEntity placeEntity) async {
    final placeModel = _mapEntityToModel(placeEntity);
    await dataSource.savePOI(placeModel);
    return true;
  }

  PlaceEntity _mapModelToEntity(PlaceModel placeModel) {
    return PlaceEntity(
      id: placeModel.id,
      name: placeModel.name,
      description: placeModel.description,
      position: LatLng(placeModel.latitude, placeModel.longitude),
    );
  }

  PlaceModel _mapEntityToModel(PlaceEntity placeEntity) {
    return PlaceModel(
      id: placeEntity.id,
      name: placeEntity.name,
      description: placeEntity.description,
      latitude: placeEntity.position.latitude,
      longitude: placeEntity.position.longitude,
    );
  }
}
