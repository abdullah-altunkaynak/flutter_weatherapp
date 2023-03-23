import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/services/location_service.dart';
import 'package:flutter_weatherapp/ui/weathermain_screen.dart';
import 'package:get/get.dart';
import 'binding/controller_binding.dart';
import 'constants/routes.dart';
import 'controller/weather_controller.dart';

void main() {
  runApp(const MyApp());
  Get.put(LocationService());
  Get.put(WeatherController());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Weather Tracker',
      debugShowCheckedModeBanner: false,
      color: Colors.transparent,
      initialRoute: '/splash-screen',
      getPages: AppRoutes.staticRoutes,
    );
  }
}