import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/ui/widgets/margin.dart';

import '../../controller/weather_controller.dart';
import '../../utils/sizes.dart';

Widget DayWeatherCard({double celcius = -999}) {
  IconData iconData = celcius > WeatherController.to.seperatorColdHotValue.value ? Icons.sunny : Icons.cloud;
  var width = Sizes.getWidth();
  var height = Sizes.getHeight();
  var fontSize = width / 100 + height / 100;
  return Column(
    children: [
      Text('Now', style: TextStyle(color: Colors.white, fontSize: fontSize),),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: iconData == Icons.sunny ? Colors.yellow : Colors.blue.shade700, size: fontSize,),
          MarginWidget(width: 10),
          Text('$celcius°C', style: TextStyle(color: Colors.white, fontSize: fontSize),),
        ],
      )
    ],
  );
}
