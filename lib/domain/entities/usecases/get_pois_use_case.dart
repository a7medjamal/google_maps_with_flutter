import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';
import 'package:dartz/dartz.dart';

class GetPOIsUseCase {
  final MapRepository repository;

  GetPOIsUseCase({required this.repository});

  Future<Either<Exception, List<PlaceEntity>>> call() async {
    try {
      final result = await repository.fetchPOIs();
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to fetch POIs: $e'));
    }
  }
}
