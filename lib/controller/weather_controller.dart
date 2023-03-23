// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weatherapp/modal/weather_response_modal.dart';
import 'package:flutter_weatherapp/services/location_service.dart';
import 'package:flutter_weatherapp/ui/widgets/show_loadingindicator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  Rx<WeatherResponseModel>? weather = new WeatherResponseModel().obs;
  RxInt nowHour = DateTime.now().toLocal().hour.obs;
  /// haftanın her gününün bir örneğini burada tutup haftalık değerler kısmında gösterebiliriz.
  RxList<List<String>> weeklyHourTemperature = [
    ['', '']
  ].obs;
  Rx<double>? weatherNow;
  RxList weatherToday = [
    ['Now', -999.0]
  ].obs; // 0.index saat, 1.index sıcaklık
  RxList weatherWeekly = [
    ['Now', -999.0]
  ].obs; // 0.index gün 1.index en düşük sıcaklık 2.index en yüksek sıcaklık
  Rx<int> seperatorColdHotValue = 7.obs;
  Rx<Position>? position; // latitude ve longitude
  Rx<Placemark>? place; // country vs.
  // Api -> https://open-meteo.com/en/docs#latitude=39.75&longitude=30.47&hourly=temperature_2m
  // geolocator ile burada konum çekip apide latitude ve longitude değerine göre request atılabilir.
  RxString baseUrl =
      'https://api.open-meteo.com/v1/forecast?latitude=39.75&longitude=30.47&hourly=temperature_2m'
          .obs;
  static WeatherController to = Get.find();
  @override
  void onInit() {
    LocationService.to.getCurrentPosition();
  }

  fetchWeather() async {
    final weatherUrl = baseUrl;
    final weatherResponse = await http.get(Uri.parse(weatherUrl.value));
    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    weather?.value = WeatherResponseModel.fromJson(weatherJson);
    setWeatherNow();
  }

  setWeatherNow() {
    weatherToday.clear();
    weatherWeekly.clear();
    var index = 0;
    var nowDate = DateTime.now().toLocal();
    var nowHour = nowDate.hour.toString();
    var nowDay = nowDate.day.toString();
    var dayforWeeklyList;
    if (nowHour.length == 1) {
      nowHour = '0$nowHour';
    }
    if (nowDay.length == 1) {
      nowDay = '0$nowDay';
    }
    var tempArray = weatherWeekly;
    weather?.value.hourly?.time?.forEach((element) {
      var splitDate = element.replaceAll(r'T', ' ').split(' ');
      var date = splitDate.first; // 2023-03-22
      var hourminute = splitDate.last; // 14:00
      var day = date.replaceAll(r'-', ' ').split(' ').last; // 22
      var hour = hourminute.replaceAll(r':', ' ').split(' ').first;
      dayforWeeklyList = day;
      if (day == nowDay) // bugünün tarihi olan hava durumu
      {
        if (hour == nowHour) {
          weatherNow = weather!.value.hourly!.temperature2m![index].obs;
        }
        if (int.parse(hour) >= int.parse(nowHour))
          weatherToday.value
              .add([hour, weather!.value.hourly!.temperature2m![index]]);
      }
      index++;
    });
  }
}
