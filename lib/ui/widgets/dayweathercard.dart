import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/ui/widgets/margin.dart';

import '../../controller/weather_controller.dart';
import '../../utils/sizes.dart';

Widget DayWeatherCard({double celcius = -999, String hour = 'Now'}) {
  IconData iconData = celcius > WeatherController.to.seperatorColdHotValue.value ? Icons.sunny : Icons.cloud;
  var width = Sizes.getWidth();
  var height = Sizes.getHeight();
  var fontSize = width / 110 + height / 110;
  return Row(children: [MarginWidget(width: 30),Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(hour, style: TextStyle(color: Colors.white, fontSize: fontSize),),

          Icon(iconData, color: iconData == Icons.sunny ? Colors.yellow : Color.fromARGB(255, 115, 115, 115), size: fontSize,),
          MarginWidget(width: 10),
          Text('$celcius°C', style: TextStyle(color: Colors.white, fontSize: fontSize),),
    ],
  )],);
}
