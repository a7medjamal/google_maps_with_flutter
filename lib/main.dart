import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:maps_app/data/datasources/map_data_source.dart';
import 'package:maps_app/data/repositories/map_repository_impl.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';
import 'package:maps_app/domain/entities/usecases/get_pois_use_case.dart';
import 'package:maps_app/domain/entities/usecases/save_poi_use_case.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';
import 'package:maps_app/presentation/screens/custom_google_map.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await setupDependencies();
    runApp(const GoogleMapsTest());
  } catch (e) {
    debugPrint('Failed to initialize app: $e');
    rethrow;
  }
}

Future<void> setupDependencies() async {
  try {
    getIt.registerLazySingleton<MapDataSource>(() => MapDataSourceImpl());

    getIt.registerLazySingleton<MapRepository>(
        () => MapRepositoryImpl(dataSource: getIt<MapDataSource>()));

    getIt.registerLazySingleton<GetPOIsUseCase>(
        () => GetPOIsUseCase(repository: getIt<MapRepository>()));

    getIt.registerLazySingleton<SavePOIUseCase>(
        () => SavePOIUseCase(repository: getIt<MapRepository>()));
  } catch (e) {
    debugPrint('Failed to setup dependencies: $e');
    rethrow;
  }
}

class GoogleMapsTest extends StatelessWidget {
  const GoogleMapsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit(
        getPOIsUseCase: getIt<GetPOIsUseCase>(),
        savePOIUseCase: getIt<SavePOIUseCase>(),
      )..loadPOIs(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomGoogleMap(),
      ),
    );
  }
}
