import 'package:flutter_weatherapp/ui/daydetail_screen.dart';
import 'package:flutter_weatherapp/ui/splash_screen.dart';
import 'package:flutter_weatherapp/ui/weathermain_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object

  static get _transition {
    if (GetPlatform.isAndroid) {
      return Transition.zoom;
    } else if (GetPlatform.isIOS) {
      return Transition.cupertino;
    } else {
      return Transition.noTransition;
    }
  }
  static final staticRoutes = [
    GetPage(
      name: '/weather-main-screen',
      page: () => WeatherMainScreen(),
      transition: _transition,
    ),GetPage(
      name: '/splash-screen',
      page: () => SplashScreen(),
      transition: _transition,
    ),GetPage(
      name: '/day-detail-screen',
      page: () => DayDetailScreen(),
      transition: _transition,
    ),];
}