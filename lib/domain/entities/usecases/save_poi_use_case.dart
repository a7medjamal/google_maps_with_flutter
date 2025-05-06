import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';
import 'package:dartz/dartz.dart'; // For handling errors or success responses

class SavePOIUseCase {
  final MapRepository repository;

  SavePOIUseCase(this.repository);

  Future<Either<Exception, bool>> call(PlaceEntity place) async {
    try {
      // Save the POI using the repository
      final result = await repository.savePOI(place);
      return Right(result); // Returning success
    } catch (e) {
      return Left(Exception('Failed to save POI: $e')); // Return error
    }
  }
}
