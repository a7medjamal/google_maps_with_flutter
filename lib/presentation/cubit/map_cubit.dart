import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/domain/entities/usecases/get_pois_use_case.dart';
import 'package:maps_app/domain/entities/usecases/save_poi_use_case.dart';
import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/presentation/cubit/map_state.dart';

class MapCubit extends Cubit<MapState> {
  final GetPOIsUseCase getPOIsUseCase;
  final SavePOIUseCase savePOIUseCase;

  MapCubit({
    required this.getPOIsUseCase,
    required this.savePOIUseCase,
  }) : super(MapInitial());

  Future<void> loadPOIs() async {
    try {
      emit(MapLoading());
      final pois = await getPOIsUseCase.execute();
      emit(MapLoaded(
        pois: pois,
        isAddingPOI: false,
        currentMapType: MapType.normal,
      ));
    } catch (e) {
      emit(MapError(message: 'Failed to load POIs: $e'));
    }
  }

  Future<void> addPOI(PlaceEntity place) async {
    try {
      final result = await savePOIUseCase.call(place);
      result.fold(
        (error) {
          emit(MapError(message: 'Failed to add POI: $error'));
        },
        (_) {
          // Update the state with the new POI added
          if (state is MapLoaded) {
            final currentState = state as MapLoaded;
            final updatedPOIs = List<PlaceEntity>.from(currentState.pois)
              ..add(place);
            emit(MapLoaded(
              pois: updatedPOIs,
              isAddingPOI: currentState.isAddingPOI,
              currentMapType: currentState.currentMapType,
            ));
          }
        },
      );
    } catch (e) {
      emit(MapError(message: 'Failed to add POI: $e'));
    }
  }

  void toggleAddingPOI() {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      emit(MapLoaded(
        pois: currentState.pois,
        isAddingPOI: !currentState.isAddingPOI,
        currentMapType: currentState.currentMapType,
      ));
    }
  }

  void setMapType(MapType mapType) {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      emit(MapLoaded(
        pois: currentState.pois,
        isAddingPOI: currentState.isAddingPOI,
        currentMapType: mapType,
      ));
    }
  }
}
