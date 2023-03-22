import 'dart:convert';
import 'package:flutter_weatherapp/modal/weather_response_modal.dart';
import 'package:flutter_weatherapp/services/location_service.dart';
import 'package:flutter_weatherapp/ui/widgets/show_loadingindicator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController{
  Rx<WeatherResponseModel>? weather = new WeatherResponseModel().obs;
  /// haftanın her gününün bir örneğini burada tutup haftalık değerler kısmında gösterebiliriz.
  RxList<List<String>> weeklyHourTemperature = [['','']].obs;
  /// günün her saatinin birer örneğini tutarak slider şeklinde bugünün saatlere dağılmış sıcaklık değerlerini gösterebiliriz.
  RxList<List<String>> dailyHourTemperature = [['','']].obs;
  Rx<double>? weatherNow;
  Rx<int> seperatorColdHotValue = 7.obs;
  Rx<Position>? position; // latitude ve longitude
  Rx<Placemark>? place; // country vs.
  // geolocator ile burada konum çekip apide latitude ve longitude değerine göre request atılabilir.
  var baseUrl ='https://api.open-meteo.com/v1/forecast?latitude=39.75&longitude=30.47&hourly=temperature_2m';
  static WeatherController to = Get.find();
  @override
  void onInit(){
    fetchWeather();
    LocationService.to.getCurrentPosition();
  }
  fetchWeather() async {
    final weatherUrl = baseUrl;
    final weatherResponse = await http.get(Uri.parse(weatherUrl));
    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    weather?.value = WeatherResponseModel.fromJson(weatherJson);
    setWeatherNow();
  }
  setWeatherNow(){
    var index = 0;
    var now = DateTime.now().toLocal();
    var nowHour = now.hour.toString();
    var nowDay = now.day.toString();
    if(nowHour.length == 1) // saat 3 ise başına sıfır koyup 03 yapmak gerekir. API de bu şekilde kayıtlı
      nowHour = '0$nowHour';
    if(nowDay.length == 1)
      nowDay = '0$nowDay';
    weather?.value.hourly?.time?.forEach((element) {
      if(element != null){
        var splitDate = element.replaceAll(r'T', ' ').split(' ');
        var date = splitDate.first; // 2023-03-22
        var hourminute = splitDate.last; // 14:00
        var day = date.replaceAll(r'-', ' ').split(' ').last; // 22
        var hour = hourminute.replaceAll(r':', ' ').split(' ').first;
        if(day == nowDay) // bugünün tarihi olan hava durumu
          if(hour == nowHour)
            weatherNow = weather!.value.hourly!.temperature2m![index].obs;
        index++;
      }
    });
  }
}