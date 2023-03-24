import 'dart:ffi';

import 'package:flutter/material.dart';

Widget Background({bool night = false, var width = 0, var height = 0}){
  return Stack(children: [Container(
                  width: width,
                  height: height,
                  child: Image.network(
                    night
                        ? 'https://wallpapers.com/images/hd/stars-4k-ultra-hd-dark-phone-sv17rfy2thpwos20.jpg'
                        : 'https://w0.peakpx.com/wallpaper/592/128/HD-wallpaper-clouds-sky-cloudy-day.jpg',
                    fit: BoxFit.cover,
                  )),
              // karanlık efekt
              Container(
                width: width,
                height: height,
                color: night ? Color.fromRGBO(0, 0, 0, 0.5) : Color.fromRGBO(0, 0, 0, 0.7),
              ),],);
}