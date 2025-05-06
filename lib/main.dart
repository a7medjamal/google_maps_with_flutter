import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maps_app/data/datasources/map_data_source.dart';
import 'package:maps_app/data/repositories/map_repository_impl.dart';
import 'package:maps_app/domain/entities/repositories/map_repository.dart';
import 'package:maps_app/domain/entities/usecases/get_pois_use_case.dart';
import 'package:maps_app/domain/entities/usecases/save_poi_use_case.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';
import 'package:maps_app/presentation/screens/custom_google_map.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        // Provide Data Sources
        Provider<MapDataSource>(
          create: (context) => MapDataSourceImpl(),
        ),

        // Provide Repositories
        Provider<MapRepository>(
          create: (context) => MapRepositoryImpl(context.read()),
        ),

        // Provide Use Cases
        Provider<GetPOIsUseCase>(
          create: (context) => GetPOIsUseCase(context.read()),
        ),
        Provider<SavePOIUseCase>(
          create: (context) => SavePOIUseCase(context.read()),
        ),
      ],
      child: const GoogleMapsTest(),
    ),
  );
}

class GoogleMapsTest extends StatelessWidget {
  const GoogleMapsTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit(
        getPOIsUseCase: context.read(),
        savePOIUseCase: context.read(),
      )..loadPOIs(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomGoogleMap(),
      ),
    );
  }
}
