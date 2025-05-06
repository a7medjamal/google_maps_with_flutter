import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';
import 'package:maps_app/presentation/cubit/map_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class POINavigationCard extends StatefulWidget {
  final GoogleMapController? mapController;
  const POINavigationCard({super.key, required this.mapController});

  @override
  State<POINavigationCard> createState() => _POINavigationCardState();
}

class _POINavigationCardState extends State<POINavigationCard> {
  int currentIndex = 0;

  void _moveToPOI(List<PlaceEntity> pois, int delta) {
    if (widget.mapController == null) return;
    setState(() {
      currentIndex = (currentIndex + delta) % pois.length;
      if (currentIndex < 0) currentIndex = pois.length - 1;
    });

    widget.mapController!.animateCamera(
      CameraUpdate.newLatLng(pois[currentIndex].position),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is! MapLoaded || state.pois.isEmpty) {
          return const SizedBox.shrink();
        }

        return Positioned(
          bottom: 16,
          left: 16,
          right: 50,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.arrow_left),
                    onPressed: () => _moveToPOI(state.pois, -1),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.arrow_right),
                    onPressed: () => _moveToPOI(state.pois, 1),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
