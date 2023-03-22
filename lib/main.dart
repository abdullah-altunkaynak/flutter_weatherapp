import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/services/location_service.dart';
import 'package:flutter_weatherapp/ui/weathermain_screen.dart';
import 'package:get/get.dart';
import 'binding/controller_binding.dart';
import 'controller/weather_controller.dart';

void main() {
  runApp(const MyApp());
  Get.put(LocationService());
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
      getPages: [
        GetPage(name: '/', page: () => WeatherMainScreen(), binding: HomeBinding())
      ],
    );
  }
}