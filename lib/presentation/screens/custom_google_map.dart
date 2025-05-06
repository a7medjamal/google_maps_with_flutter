import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';
import 'package:maps_app/presentation/cubit/map_state.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  BitmapDescriptor? customIcon;
  LatLng? tappedPosition;

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
              actions: [
                IconButton(
                  icon: const Icon(Icons.satellite),
                  onPressed: () {
                    final currentMapType = state.currentMapType;
                    final newMapType = currentMapType == MapType.normal
                        ? MapType.satellite
                        : MapType.normal;
                    context.read<MapCubit>().setMapType(newMapType);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add_location_alt),
                  onPressed: () => context.read<MapCubit>().toggleAddingPOI(),
                ),
              ],
            ),
            body: Stack(
              children: [
                GoogleMap(
                  mapType: state.currentMapType,
                  markers: _createMarkers(state.pois),
                  onMapCreated: (controller) {},
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(31.040961, 31.378491),
                    zoom: 15,
                  ),
                  onTap: (LatLng position) {
                    if (state.isAddingPOI) {
                      _showAddPOIDialog(context, position);
                    }
                  },
                ),
                if (state.isAddingPOI)
                  Positioned(
                    bottom: 100,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(Icons.add_location),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
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

  void _showAddPOIDialog(BuildContext context, LatLng position) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Point of Interest'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter name'),
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(hintText: 'Enter description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = nameController.text.trim();
                final description = descriptionController.text.trim();

                if (name.isNotEmpty && description.isNotEmpty) {
                  final newPOI = PlaceEntity(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: name,
                    description: description,
                    position: position,
                  );
                  context.read<MapCubit>().addPOI(newPOI);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
