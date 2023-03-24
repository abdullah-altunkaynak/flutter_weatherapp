import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_weatherapp/controller/weather_controller.dart';
import 'package:flutter_weatherapp/ui/widgets/dayweathercard.dart';
import 'package:flutter_weatherapp/ui/widgets/margin.dart';
import 'package:flutter_weatherapp/ui/widgets/platform_widget.dart';
import 'package:get/get.dart';

import '../utils/sizes.dart';
import 'widgets/background.dart';
import 'widgets/weeklyweathercard.dart';

class WeatherMainScreen extends StatefulWidget {
  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen>{
  var width = Sizes.getWidth();
  var height = Sizes.getHeight();
  WeatherController c = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(
    //     builder: (BuildContext context, BoxConstraints constraints) {
    //   // eğer screen width >= 1024 laptop veya masaüstü web veya masaüstü uygulamalar
    //   if (constraints.maxWidth >= 1024) {
    //     return SizedBox();
    //     // return desktopDesign();
    //   }
    //   // tablet görünümü
    //   else if (constraints.maxWidth <= 1023 && constraints.maxWidth >= 768) {
    //     return SizedBox();
    //     // return tabletDesign();
    //   }
    //   // telefon görünümü 767-320
    //   else {
    //     return phoneDesign();
    //   }
    // });
    return PlatformWidget(
      androidBuilder: phonetabletDesign,
      iosBuilder: phonetabletDesign,
      webBuilder: width >= 1024 ? wideDesign : phonetabletDesign,
    );
  }

  Widget phonetabletDesign(BuildContext context) {
    // Timer(Duration(seconds: 5), () async {
    //   print('timer çalıştı');
    // });
    print('phoneDesign başlatıldı!');
    var nowTime = DateTime.now().toLocal();
    var nowTimeHour = nowTime.hour;
    var nowTimeMinute = nowTime.minute;
    return Obx(() => Scaffold(
          body:  Stack(
            children: [
              // arkaplan resim
              Background(width: width, height: height, night: nowTimeHour >= 18 || nowTimeHour < 06),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MarginWidget(height: 10),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: width / 70 + height / 70,
                        ),
                        Text(
                          c.place != null
                              ? c.place!.value.locality.toString()
                              : 'Eskişehir',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: width / 70 + height / 70),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Text(
                        'Last update $nowTimeHour:$nowTimeMinute',
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: width / 150 + height / 150),
                      )),
                  MarginWidget(height: 10),
                  Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: c.weatherToday.length,
                        itemBuilder: (context, index) {
                          return DayWeatherCard(
                              celcius: c.weatherToday.value[index][1] ?? -999,
                              hour: index == 0
                                  ? 'Now'
                                  : c.weatherToday.value[index][0] ?? 'Now');
                        },
                        scrollDirection: Axis.horizontal,
                      )),
                  Expanded(
                      flex: 10,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(8),
                                ),
                            width: width,
                            height: height / 4,
                            child: ListView.builder(
                                itemCount:
                                    c.weather?.value.hourly?.time?.length ?? 0,
                                itemBuilder: ((context, index) {
                                  if (index % 12 == 0) {
                                    return InkWell(
                                        onTap: () {
                                          c.setWeather(forNow: false, dateForDetail: c.weather?.value.hourly
                                                    ?.time?[index] ??
                                                '');
                                          Get.toNamed('day-detail-screen', arguments: {'day': c.weather?.value.hourly
                                                    ?.time?[index] ??
                                                ''});
                                        },
                                        child: weeklyWeatherCard(
                                            date: c.weather?.value.hourly
                                                    ?.time?[index] ??
                                                '',
                                            celcius: c.weather?.value.hourly
                                                    ?.temperature2m?[index] ??
                                                -999));
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                })),
                          ))),
                ],
              )
            ],
          ),
        ));
  }

  Widget wideDesign(BuildContext context) {
    // tablet veya telefon ekranı değilse geniş ekran için
    return SizedBox();
  }
}
