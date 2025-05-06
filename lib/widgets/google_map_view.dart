import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';
import 'package:maps_app/presentation/cubit/map_state.dart';
import 'package:maps_app/widgets/add_poi_dialog.dart';

class GoogleMapView extends StatefulWidget {
  final void Function(GoogleMapController)? onMapCreated;
  const GoogleMapView({super.key, this.onMapCreated});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  BitmapDescriptor? customIcon;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
  }

  Future<void> _loadCustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/marker_icon.png',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is! MapLoaded) return const SizedBox.shrink();

        return GoogleMap(
          mapType: state.currentMapType,
          markers: _createMarkers(state.pois),
          polylines: _createPolylines(state.pois),
          onMapCreated: (controller) {
            mapController = controller;
            widget.onMapCreated?.call(controller);
          },
          initialCameraPosition: const CameraPosition(
            target: LatLng(31.040961, 31.378491),
            zoom: 15,
          ),
          onTap: (position) {
            if (state.isAddingPOI) {
              showAddPOIDialog(context, position);
            }
          },
        );
      },
    );
  }

  Set<Marker> _createMarkers(List<PlaceEntity> pois) {
    return pois.map((place) {
      return Marker(
        markerId: MarkerId(place.id.toString()),
        position: place.position,
        icon: customIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: place.name, snippet: place.description),
      );
    }).toSet();
  }

  Set<Polyline> _createPolylines(List<PlaceEntity> pois) {
    if (pois.length < 2) return {};
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: pois.map((e) => e.position).toList(),
        color: Colors.blue,
        width: 3,
      )
    };
  }
}
