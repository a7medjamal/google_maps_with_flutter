import 'package:maps_app/data/models/placemodel.dart';

abstract class MapDataSource {
  Future<List<PlaceModel>> fetchPOIs();    // Fetch POIs from the source
  Future<void> savePOI(PlaceModel place);   // Save a POI to the source
}

class MapDataSourceImpl implements MapDataSource {
  // Temporary in-memory storage to simulate the data source
  final List<PlaceModel> _placeStore = [];

  @override
  Future<List<PlaceModel>> fetchPOIs() async {
    // Simulating fetching POIs from a database or network
    // This could be replaced with real database queries or network requests
    await Future.delayed(const Duration(seconds: 1)); // Simulating delay
    return _placeStore; // Return the in-memory list of places
  }

  @override
  Future<void> savePOI(PlaceModel place) async {
    // Simulate saving POI to a database or network
    await Future.delayed(const Duration(seconds: 1)); // Simulating delay
    _placeStore.add(place); // Add the place to the in-memory store
  }
}
