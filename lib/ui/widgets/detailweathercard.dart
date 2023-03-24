import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/ui/widgets/margin.dart';
import 'package:flutter_weatherapp/utils/sizes.dart';

Widget DetailWeatherCard({var value, var icon}) {
  var width = Sizes.getWidth();
  var height = Sizes.getHeight();
  return Row(
    children: [
      MarginWidget(width: 30),
      Container(
        padding: EdgeInsets.all(10),
        width: width / 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              value,
              style: TextStyle(fontSize: width / 120 + height / 120,color: Colors.deepOrange.shade800),
            )
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 8, 80, 139)),
            color: Color.fromRGBO(64, 65, 65, 0.5),
            borderRadius: BorderRadius.all(Radius.circular(7))),
      )
    ],
  );
}
