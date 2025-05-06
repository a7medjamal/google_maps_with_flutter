import 'package:maps_app/data/datasources/map_data_source.dart';
import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';
import 'package:maps_app/data/models/placemodel.dart'; // Import PlaceModel for conversion
import 'package:google_maps_flutter/google_maps_flutter.dart'; // For LatLng

class MapRepositoryImpl implements MapRepository {
  final MapDataSource dataSource;

  MapRepositoryImpl(this.dataSource);

  @override
  Future<List<PlaceEntity>> getPOIs() async {
    try {
      // Fetch POIs from the data source (which returns a List<PlaceModel>)
      final placeModels = await dataSource.fetchPOIs();

      // Convert PlaceModel to PlaceEntity and return
      return placeModels.map((place) => _mapToPlaceEntity(place)).toList();
    } catch (e) {
      throw Exception('Failed to get POIs: $e');
    }
  }

  @override
  Future<bool> savePOI(PlaceEntity place) async {
    try {
      // Convert PlaceEntity to PlaceModel
      final placeModel = _mapToPlaceModel(place);

      // Save the POI using the data source
      await dataSource.savePOI(placeModel);
      return true;  // Return success
    } catch (e) {
      throw Exception('Failed to save POI: $e');
    }
  }

  // Helper method to map PlaceModel to PlaceEntity
  PlaceEntity _mapToPlaceEntity(PlaceModel placeModel) {
    return PlaceEntity(
      id: placeModel.id,
      name: placeModel.name,
      description: placeModel.description,
      position: LatLng(placeModel.latitude, placeModel.longitude), // Convert latitude and longitude to LatLng
    );
  }

  // Helper method to map PlaceEntity to PlaceModel
  PlaceModel _mapToPlaceModel(PlaceEntity placeEntity) {
    return PlaceModel(
      id: placeEntity.id,
      name: placeEntity.name,
      description: placeEntity.description,
      latitude: placeEntity.position.latitude, // Use latitude from LatLng
      longitude: placeEntity.position.longitude, // Use longitude from LatLng
    );
  }
}
