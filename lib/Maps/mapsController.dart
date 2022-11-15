import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/Maps/directionsModel.dart';
import 'package:maps/Maps/directions_repository.dart';

class MapController extends GetxController {
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(31.499834, 34.462982),
    zoom: 11.5,
  );
  late GoogleMapController googleMapController;
  Marker? origin;
  Marker? destination;
  Directions? info;

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  Polygon? po;
  Polyline polyline = Polyline(polylineId: PolylineId("kplyline"), points: []);

  void addMarker(LatLng pos) async {
    if (origin == null || (origin != null && destination != null)) {
      origin = Marker(
        markerId: const MarkerId("origin"),
        infoWindow: const InfoWindow(title: "Origin"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
      destination = null;
      info = null;

      update();
    } else {
      destination = Marker(
        markerId: const MarkerId("destination"),
        infoWindow: const InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
      update();
      Directions directions =
          await getDistance(origin: origin!.position, destination: pos);
      if (directions.isEmpty) {
        info = null;
      } else {
        info = directions;
      }

      update();
    }
  }
}
