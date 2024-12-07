import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/ws/models/ws_weather.dart';

class WSApi {

  final String url;
  final String apiKey;

  WSApi(this.url, this.apiKey);

  Future<WSWeather> getWeather(double x, double y) async {
    var responce = await http.get(Uri.parse('$url/current?access_key=$apiKey&query=$x,$y'));
    var rJson = jsonDecode(responce.body);
    return WSWeather(rJson['current']['temperature'], rJson['current']['weather_descriptions'][0]);
  }

  Future<WSWeather> getWeatherCity(String city) async {
    var responce = await http.get(Uri.parse('$url/current?access_key=$apiKey&query=$city'));
    var rJson = jsonDecode(responce.body);
    return WSWeather(rJson['current']['temperature'], rJson['current']['weather_descriptions'][0]);
  }


}