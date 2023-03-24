import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/ui/widgets/background.dart';
import 'package:flutter_weatherapp/ui/widgets/margin.dart';
import 'package:get/get.dart';

import '../controller/weather_controller.dart';
import '../utils/sizes.dart';
import 'widgets/dayweathercard.dart';
import 'widgets/detailweathercard.dart';
import 'widgets/platform_widget.dart';

class DayDetailScreen extends StatelessWidget {
  /// detayı verilecek günün tarihi
  String dayDate = Get.arguments['day'];
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
    String date = dayDate.replaceAll(r'T',' ').split(' ')[0];
    String year = date.replaceAll(r'-', ' ').split(' ')[0];
    String month = date.replaceAll(r'-', ' ').split(' ')[1];
    String day = date.replaceAll(r'-', ' ').split(' ')[2];
    String dateForText = '$year $month $day';
    return Scaffold(
      body: Stack(children: [
        Background(
            width: width,
            height: height,
            night: nowTime.hour >= 18 || nowTime.hour < 06),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MarginWidget(height: 20),
            Expanded(
              flex: 1,
              child: Align(alignment: Alignment.centerLeft, child:IconButton(
                  onPressed: () => Get.back(),
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                    size: 30,
                  ))),
            ),
            MarginWidget(height: 10),
            Expanded(flex: 1,child: Text(dateForText, style: TextStyle(color: Colors.white,fontSize: width / 80 + height / 80),)),
            MarginWidget(height: 20),
            Expanded(
                flex: 10,
                child: ListView.builder(
                  itemCount: c.weatherforDetail.length,
                  itemBuilder: (context, index) {
                    return Container(
                        color: Color.fromARGB(102, 52, 52, 52),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DayWeatherCard(
                                celcius:
                                    c.weatherforDetail.value[index][1] ?? -999,
                                hour: c.weatherforDetail.value[index][0]),
                            MarginWidget(height: 20),
                            DetailWeatherCard(
                                value: c.weatherforDetail[index][2] != null
                                    ? c.weatherforDetail[index][2].toString()
                                    : 999.toString(),
                                icon: Icons.percent),
                            MarginWidget(height: 10),
                            DetailWeatherCard(
                                value: c.weatherforDetail[index][3] != null
                                    ? c.weatherforDetail[index][3].toString()
                                    : 999.toString(),
                                icon: Icons.snowing),
                            MarginWidget(height: 10),
                            DetailWeatherCard(
                                value: c.weatherforDetail[index][4] != null
                                    ? c.weatherforDetail[index][4].toString()
                                    : 999.toString(),
                                icon: Icons.wind_power_rounded),
                            MarginWidget(height: 10),
                            DetailWeatherCard(
                                value: c.weatherforDetail[index][4] != null
                                    ? c.weatherforDetail[index][4].toString()
                                    : 999.toString(),
                                icon: Icons.code),
                          ],
                        ));
                  },
                  scrollDirection: Axis.horizontal,
                )),
                MarginWidget(height: 20),
            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.percent,
                          color: Colors.white,
                        ),
                        Container(width: width / 3,child:Text(
                            'Probability of precipitation with more than 0.1 mm of the preceding hour. Probability is based on ensemble weather models with 0.25° (~27 km) resolution. 30 different simulations are computed to better represent future weather conditions.', style: TextStyle(color: Colors.grey),))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.snowing,
                          color: Colors.white,
                        ),
                        Container(width: width / 3, child: Text(
                            'Total precipitation (rain, showers, snow) sum of the preceding hour', style: TextStyle(color: Colors.grey)))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.wind_power_rounded,
                          color: Colors.white,
                        ),
                        Container(width: width / 3, child: Text(
                            'Wind speed at 10 above ground. Wind speed on 10 meters is the standard level.', style: TextStyle(color: Colors.grey)))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.code,
                          color: Colors.white,
                        ),
                        Container(width: width / 3, child: Text(
                            'Weather condition as a numeric code. Follow WMO weather interpretation codes.', style: TextStyle(color: Colors.grey)))
                      ],
                    ),
                  ],
                ))
          ],
        )
      ]),
    );
  }

  Widget wideDesign(BuildContext context) {
    return SizedBox.shrink();
  }
}
