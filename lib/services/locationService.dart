import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
class LocationService{

  static Future determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Your Location Services are Disabled!")));


      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Location permissions are denied.Kindly give permission to location Services")));

        return 'Location permissions are denied.Kindly give permission to location Services';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Location permissions are permanently denied, we cannot request permissions.")));
      return
          'Location permissions are permanently denied, we cannot request permissions.';
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


}
