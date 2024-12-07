import 'package:practice_1/features/core/data/osm/osm_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;
  App(this.repository);

  void run() async {

    print("Введите название города или координаты широты и долготы через пробел");
    var input = stdin.readLineSync();

    if (input==null) {
      print("Ошибка ввода");
      return;
    }
    if (input.contains(' ')) {
      var parts = input.split(' ');
      var x = double.parse(parts[0]);
      var y = double.parse(parts[1]);
      var resp = await repository.getWeather(SearchQueryCoords(x,y));
      print('Погода в городе $input: ${resp.temp} по Цельсию, тип: ${weatherToString(resp.type)}');

    } else {
      var resp = await repository.getWeather(SearchQueryCity(input));
      print('Погода в городе $input: ${resp.temp} по Цельсию, тип: ${weatherToString(resp.type)}');

    }
  }
}

String weatherToString(WeatherType type){
  switch (type){
    case WeatherType.cloudy:
      return 'Облачно';
    case WeatherType.clear:
      return 'Безоблачно';
    case WeatherType.rain:
      return 'Дождь';
    case WeatherType.sunny:
      return 'Солнечно';
    case WeatherType.snow:
      return 'Снег';
    case WeatherType.other:
      return 'Другое';
  }
}
