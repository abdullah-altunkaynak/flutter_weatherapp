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
import 'widgets/weeklyweathercard.dart';

class WeatherMainScreen extends StatefulWidget {
  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen>
    with TickerProviderStateMixin {
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
    print('phoneDesign başlatıldı!');
    var nowTime = DateTime.now().toLocal();
    var nowTimeHour = nowTime.hour;
    var nowTimeMinute = nowTime.minute;
    return Obx(() => Scaffold(
          body: SafeArea(
              child: Stack(
            children: [
              // arkaplan resim
              Container(
                  width: width,
                  height: height,
                  child: Image.network(
                    'https://w0.peakpx.com/wallpaper/978/53/HD-wallpaper-sunny-day-blue-clouds-light-sky.jpg',
                    fit: BoxFit.fitWidth,
                  )),
              // karanlık efekt
              Container(
                width: width,
                height: height,
                color: Color.fromRGBO(0, 0, 0, 0.8),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.orange,
                          size: 50,
                        ),
                        Text(
                          c.place?.value.locality != null ? c.place!.value.locality.toString()  : 'Eskişehir',
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
                      child:
                          DayWeatherCard(celcius: c.weatherNow?.value ?? -999)),
                  //         CarouselSlider(
                  //   options: CarouselOptions(),
                  //   items: list
                  //       .map((item) => Container(
                  //             child: Center(child: Text(item.toString())),
                  //             color: Colors.green,
                  //           ))
                  //       .toList(),
                  // )
                  Expanded(
                      flex: 10,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color.fromRGBO(158, 158, 158, 0.3)),
                            width: Sizes.getWidth(),
                            height: Sizes.getHeight() / 4,
                            child: ListView.builder(
                                itemCount:
                                    c.weather?.value.hourly?.time?.length,
                                itemBuilder: ((context, index) {
                                  return weeklyWeatherCard(
                                      date: c.weather?.value.hourly
                                              ?.time?[index] ??
                                          '',
                                      celcius: c.weather?.value.hourly
                                              ?.temperature2m?[index] ??
                                          -999);
                                })),
                          ))),
                ],
              )
            ],
          )),
        ));
  }

  Widget wideDesign(BuildContext context) {
    // tablet veya telefon ekranı değilse geniş ekran için
    return SizedBox();
  }
}
