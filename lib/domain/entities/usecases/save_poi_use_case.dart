import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';
import 'package:dartz/dartz.dart';

class SavePOIUseCase {
  final MapRepository repository;

  SavePOIUseCase({required this.repository});

  Future<Either<Exception, bool>> call(PlaceEntity place) async {
    try {
      final result = await repository.savePOI(place);
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to save POI: $e'));
    }
  }
}
