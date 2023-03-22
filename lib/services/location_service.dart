import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/controller/weather_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxService {
  static final LocationService to = Get.find<LocationService>();
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
              Get.snackbar('Error!', 'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
          Get.snackbar('Access Denied', 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
        Get.snackbar('Access Denied', 'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
  Future<void> getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();
  if (!hasPermission) return;
  await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
      .then((Position position) {
    WeatherController.to.position = position.obs;
    getAddressFromLatLng(position);
  }).catchError((e) {
    debugPrint(e);
  });
}
Future<void> getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(
          position.latitude, position.longitude)
      .then((List<Placemark> placemarks) {
    WeatherController.to.place = placemarks[0].obs;
    print(placemarks[0].locality);
  }).catchError((e) {
    debugPrint(e);
  });
 }
}
