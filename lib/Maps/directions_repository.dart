import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:maps/Maps/directionsModel.dart';

Future<dynamic> getDistance({
  required LatLng origin,
  required LatLng destination,
}) async {
  String Url =
      'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${destination.latitude},${destination.longitude}&origins=${origin.latitude},${origin.longitude}&key=AIzaSyAZnjksIZ0ifQFezxR2EcbCHHLHvD94WD0';
  try {
    var response = await http.get(
      Uri.parse(Url),
      // headers:
    );
    if (response.statusCode == 200) {
      print(response.body);
      return Directions.fromMap(jsonDecode(response.body));
    } else
      return null;
  } catch (e) {
    print(e);
    return null;
  }
}
