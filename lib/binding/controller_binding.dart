import 'package:flutter_weatherapp/services/location_service.dart';
import 'package:get/get.dart';

import '../controller/weather_controller.dart';
class HomeBinding extends Bindings {
  @override
  void dependencies() {
     Get.put(WeatherController());
     Get.put(LocationService());
  }
}