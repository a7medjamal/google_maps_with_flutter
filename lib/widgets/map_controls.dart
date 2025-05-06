import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';
import 'package:maps_app/presentation/cubit/map_state.dart';

class MapControls extends StatelessWidget {
  const MapControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is! MapLoaded) return const SizedBox.shrink();

        return Row(
          children: [
            IconButton(
              icon: const Icon(Icons.satellite),
              onPressed: () {
                final newMapType = state.currentMapType == MapType.normal
                    ? MapType.satellite
                    : MapType.normal;
                context.read<MapCubit>().setMapType(newMapType);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_location_alt),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tap on the map to choose a location.'),
                  ),
                );
                context.read<MapCubit>().toggleAddingPOI();
              },
            ),
          ],
        );
      },
    );
  }
}
