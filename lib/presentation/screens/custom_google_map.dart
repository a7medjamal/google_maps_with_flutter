import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';
import 'package:maps_app/presentation/cubit/map_state.dart';
import 'package:maps_app/widgets/google_map_view.dart';
import 'package:maps_app/widgets/map_controls.dart';
import 'package:maps_app/widgets/poi_navigation_card.dart';

class CustomGoogleMapPage extends StatefulWidget {
  const CustomGoogleMapPage({super.key});

  @override
  State<CustomGoogleMapPage> createState() => _CustomGoogleMapPageState();
}

class _CustomGoogleMapPageState extends State<CustomGoogleMapPage> {
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        if (state is MapError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is MapLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MapError) {
          return Center(child: Text(state.message));
        } else if (state is MapLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Custom Google Map'),
              actions: const [MapControls()],
            ),
            body: Stack(
              children: [
                GoogleMapView(onMapCreated: _onMapCreated),
                if (state.pois.isNotEmpty)
                  POINavigationCard(mapController: mapController),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
