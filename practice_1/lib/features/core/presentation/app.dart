import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;

  App(this.repository);

  void run() async {
    print('Введите город:');
    var city = stdin.readLineSync();

    if (city == null) {
      print('Ошибка ввода');
      return;
    }

    var resp = await repository.getWeather(SearchQuery(city));
    print('Погода в городе $city: ${resp.temp} по Цельсию, тип: ${weatherTypeToString(resp.type)}');
  }
}

String weatherTypeToString(WeatherType type) {
  switch (type) {
    case WeatherType.cloudy:
      return 'Clouds';
    case WeatherType.clear:
      return 'Clear';
    case WeatherType.rain:
      return 'Rain';
    case WeatherType.sunny:
      return 'Sunny';
    default:
      return 'Other';
  }
}