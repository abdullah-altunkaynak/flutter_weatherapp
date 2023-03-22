import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/controller/weather_controller.dart';

import '../../utils/sizes.dart';

Widget weeklyWeatherCard({String date = '', double celcius = -999}) {
  var width = Sizes.getWidth();
  var height = Sizes.getHeight();
  var fontSize = width / 120 + height / 120;
  return Center(
      child: Container(
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade600))),
    padding: EdgeInsets.all(10),
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          date.replaceAll(r'T', ' '),
          style: TextStyle(color: Colors.grey.shade500, fontSize: fontSize),
        ),
        Icon(
          celcius > WeatherController.to.seperatorColdHotValue.value ? Icons.sunny : Icons.cloud,
          color: celcius > WeatherController.to.seperatorColdHotValue.value ? Colors.yellow : Colors.blue,
          size: fontSize,
        ),
        Text(
          '$celcius°C',
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        )
      ],
    ),
  ));
}
