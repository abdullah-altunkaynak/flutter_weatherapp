import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/ui/widgets/background.dart';
import 'package:flutter_weatherapp/ui/widgets/margin.dart';
import 'package:get/get.dart';

import '../controller/weather_controller.dart';
import '../utils/sizes.dart';
import 'widgets/dayweathercard.dart';
import 'widgets/platform_widget.dart';

class DayDetailScreen extends StatelessWidget {
  /// detayı verilecek günün tarihi
  var dayDate = Get.arguments['day'];
  var width = Sizes.getWidth();
  var height = Sizes.getHeight();
  WeatherController c = Get.put(WeatherController());
  var nowTime = DateTime.now().toLocal();
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: phonetabletDesign,
      iosBuilder: phonetabletDesign,
      webBuilder: width >= 1024 ? wideDesign : phonetabletDesign,
    );
  }

  Widget phonetabletDesign(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Background(
            width: width,
            height: height,
            night: nowTime.hour >= 18 || nowTime.hour < 06),
        Column(
          children: [
            MarginWidget(height: 20),
            IconButton(
                onPressed: () {
                  print('Tıklandı!');
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_sharp)),
                Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: c.weatherforDetail.length,
                        itemBuilder: (context, index) {
                          return DayWeatherCard(
                              celcius: c.weatherforDetail.value[index][1] ?? -999,
                              hour: c.weatherforDetail.value[index][0]);
                        },
                        scrollDirection: Axis.horizontal,
                      )),
          ],
        )
      ]),
    );
  }

  Widget wideDesign(BuildContext context) {
    return SizedBox.shrink();
  }
}
