import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/Maps/mapsController.dart';

class MyMap extends StatelessWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      global: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title: const Text(
              'Google Maps',
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
            ),
            actions: [
              if (controller.origin != null)
                TextButton(
                  onPressed: () {
                    controller.googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: controller.origin!.position,
                          zoom: 14.5,
                          tilt: 50.0,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  child: const Text('ORIGIN'),
                ),
              if (controller.destination != null)
                TextButton(
                  onPressed: () {
                    controller.googleMapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: controller.destination!.position,
                          zoom: 14.5,
                          tilt: 50.0,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Destination'),
                )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.black,
            child: const Icon(
              Icons.center_focus_strong,
            ),
            onPressed: () {
              controller.googleMapController.animateCamera(
                controller.info != null
                    ? CameraUpdate.newLatLngBounds(controller.info!.bounds, 100)
                    : CameraUpdate.newCameraPosition(
                        controller.initialCameraPosition,
                      ),
              );
            },
          ),
          body: GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: controller.initialCameraPosition,
            onMapCreated: (controller2) {
              controller.googleMapController = controller2;
            },
            polylines: {
              if (controller.info != null)
                Polyline(
                  polylineId: const PolylineId("polyline"),
                  color: Colors.red,
                  width: 5,
                  points: controller.info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                )
            },
            markers: {
              if (controller.origin != null) controller.origin!,
              if (controller.destination != null) controller.destination!,
            },
            onLongPress: controller.addMarker,
          ),
        );
      },
    );
  }
}
