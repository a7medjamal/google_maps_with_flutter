import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/domain/entities/place_entity.dart';
import 'package:maps_app/presentation/cubit/map_cubit.dart';

void showAddPOIDialog(BuildContext context, LatLng position) {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  showDialog<void>(
    context: context,
    builder: (_) {
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
              decoration: const InputDecoration(hintText: 'Enter description'),
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
