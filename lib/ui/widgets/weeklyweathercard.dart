import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/controller/weather_controller.dart';
import 'package:intl/intl.dart';
import '../../utils/sizes.dart';

Widget weeklyWeatherCard({String date = '', double celcius = -999}) {
  var weekday = ' '; // DEFAULT
  int hour = 0;
  try{
  DateTime datetimeDate = DateTime.parse(date);
  hour = int.parse(date.split('T')[1].split(':')[0]);
  print(hour);
  weekday = DateFormat('EEEE').format(datetimeDate);}catch(error){
    print('in weeklyWeatherCard widget, datetime convert error: ' + error.toString());
  }
  var width = Sizes.getWidth();
  var height = Sizes.getHeight();
  var fontSize = width / 120 + height / 120;
  return Center(
      child: Container(
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white),),
        color: hour > 17 || hour < 6 ? Color.fromARGB(126, 28, 28, 28) : Color.fromRGBO(90, 146, 175, 0.5)),
    padding: EdgeInsets.all(20),
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(flex: 3, child: Text(
          '$weekday - ' + date.replaceAll(r'T', ' ').split(' ')[1],
          style: TextStyle(color: Colors.white, fontSize: fontSize / 1.3),
          textAlign: TextAlign.center,
        )),
        Expanded(flex: 1, child: Icon(
          celcius > WeatherController.to.seperatorColdHotValue.value ? Icons.sunny : Icons.cloud,
          color: celcius > WeatherController.to.seperatorColdHotValue.value ? Colors.yellow : Colors.blue,
          size: fontSize,
        )),
        Expanded(flex: 2, child: Text(
          '$celcius°C',
          style: TextStyle(color: Colors.white, fontSize: fontSize),
          textAlign: TextAlign.center,
        ))
      ],
    ),
  ));
}
