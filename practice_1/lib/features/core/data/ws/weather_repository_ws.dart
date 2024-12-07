import 'package:practice_1/features/core/data/ws/ws_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryWS implements WeatherRepository {
  final WSApi _api;
  WeatherRepositoryWS(this._api);

  @override
  Future<SearchResponce> getWeather(SearchQuery query) async {
    if (query is SearchQueryCoords) {
      var response = await _api.getWeather(query.x, query.y);
      return SearchResponce(response.temp.toInt(), _weatherType(response.type));
    }
    else if (query is SearchQueryCity){
        var response = await _api.getWeatherCity(query.city);
        return SearchResponce(response.temp.toInt(), _weatherType(response.type));
    }
    else {
      throw ArgumentError();
    }
  }
}

WeatherType _weatherType(String type) {
  switch (type){
    case 'Clouds':
      return WeatherType.cloudy;
    case 'Clear':
      return WeatherType.clear;
    case 'Rain':
      return WeatherType.rain;
    case 'Sunny':
      return WeatherType.sunny;
    case 'Cloudly':
      return WeatherType.cloudy;
    case 'Snow':
      return WeatherType.snow;
    default:
      return WeatherType.other;
  }
}