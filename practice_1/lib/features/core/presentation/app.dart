import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;

  App(this.repository);

  void run() async {
    print('Введите город или координаты (широта, долгота):');
    var input = stdin.readLineSync();

    if (input == null) {
      print('Ошибка ввода');
      return;
    }

    SearchQuery query;
    if (input.contains(',')) {
      var coords = input.split(',');
      if (coords.length != 2) {
        print('Неверный формат координат');
        return;
      }
      var latitude = double.tryParse(coords[0].trim());
      var longitude = double.tryParse(coords[1].trim());
      if (latitude == null || longitude == null) {
        print('Неверный формат координат');
        return;
      }
      query = SearchQueryByCoords(latitude, longitude);
    } else {
      query = SearchQueryByCity(input);
    }

    var resp = await repository.getWeather(query);
    print('Погода в этой локации: ${resp.temp} по Цельсию, тип: ${weatherTypeToString(resp.type)}');
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