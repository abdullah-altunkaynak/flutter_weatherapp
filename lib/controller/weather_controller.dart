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
  Rx<WeatherResponseModal>? weather = new WeatherResponseModal().obs;
  RxInt nowHour = DateTime.now().toLocal().hour.obs;

  /// haftanın her gününün bir örneğini burada tutup haftalık değerler kısmında gösterebiliriz.
  RxList<List<String>> weeklyHourTemperature = [
    ['', '']
  ].obs;
  Rx<double>? weatherNow;
  RxList weatherToday = [
    ['Now', -999.0]
  ].obs; // 0.index saat, 1.index sıcaklık
  RxList weatherforDetail = [
    ['Now', -999.0, 10, 10.0, 10.0, 10]
  ].obs; // detay sayfasında istenen gün için özel olarak çekilmiş veriler (0. saat, 1. sıcaklık, 2.yağış olasılığı, 3.toplam yağış, 4.rüzgar hızı, 5.hava kodu)
  Rx<int> seperatorColdHotValue = 7.obs;
  Rx<Position>? position; // latitude ve longitude
  Rx<Placemark>? place; // country vs.
  // Api -> https://open-meteo.com/en/docs#latitude=39.75&longitude=30.47&hourly=temperature_2m
  // geolocator ile burada konum çekip apide latitude ve longitude değerine göre request atılabilir.
  RxString baseUrl =
      'https://api.open-meteo.com/v1/forecast?latitude=39.75&longitude=30.47&hourly=temperature_2m,precipitation_probability,precipitation,weathercode,windspeed_10m'
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
    weather?.value = WeatherResponseModal.fromJson(weatherJson);
    setWeather();
  }

  setWeather({bool forNow = true, String? dateForDetail}) {
    var index = 0;
    print('forNow: ' + forNow.toString());
    // forNow eğer true ise bugünün verilerini ayarlamak istiyoruzdur
    if (forNow) {
      weatherToday.clear();
      var nowDate = DateTime.now().toLocal();
      var nowHour = nowDate.hour.toString();
      var nowDay = nowDate.day.toString();
      if (nowHour.length == 1) {
        nowHour = '0$nowHour';
      }
      if (nowDay.length == 1) {
        nowDay = '0$nowDay';
      }
      weather?.value.hourly?.time?.forEach((element) {
        var splitDate = element.replaceAll(r'T', ' ').split(' ');
        var date = splitDate.first; // 2023-03-22
        var hourminute = splitDate.last; // 14:00
        var day = date.replaceAll(r'-', ' ').split(' ').last; // 22
        var hour = hourminute.replaceAll(r':', ' ').split(' ').first;
        if (day == nowDay) // bugünün tarihi olan hava durumu
        {
          if (hour == nowHour) {
            weatherNow = weather!.value.hourly!.temperature2m![index].obs;
          }
          if (int.parse(hour) >= int.parse(nowHour))
            weatherToday.value.add([
              hour,
              weather!.value.hourly!.temperature2m![index],
            ]);
        }
        index++;
      });
    }
    // eğer forNow false ise detay sayfasındaki tarih için veri ayarlamak istiyoruzdur
    else {
      weatherforDetail.clear();
      if (dateForDetail != null) {
        print('dateForDetail boş değil');
        weather?.value.hourly?.time?.forEach((element) {
          var splitDate = element.replaceAll(r'T', ' ').split(' ');
          var date = splitDate.first; // 2023-03-22
          var hourminute = splitDate.last; // 14:00
          var day = date.replaceAll(r'-', ' ').split(' ').last; // 22
          var hour = hourminute.replaceAll(r':', ' ').split(' ').first;

          var dayForDetail = dateForDetail
              .replaceAll(r'T', ' ')
              .split(' ')
              .first
              .replaceAll(r'-', ' ')
              .split(' ')
              .last; // 22
          if (day == dayForDetail) // istenen günün tarihi olan hava durumu
          {
            print('ekleme yapacak');
            weatherforDetail.value.add([
              hour,
              weather!.value.hourly!.temperature2m![index],
              weather!.value.hourly!.precipitationProbability![index],
              weather!.value.hourly!.precipitation![index],
              weather!.value.hourly!.windspeed10m![index],
              weather!.value.hourly!.weathercode![index]
            ]);
          }
          index++;
        });
      }
      print(weatherforDetail);
    }
  }
}
