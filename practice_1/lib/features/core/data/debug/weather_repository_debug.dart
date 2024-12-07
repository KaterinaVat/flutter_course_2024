import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryDebug implements WeatherRepository {
  @override
  Future<SearchResponce> getWeather(SearchQuery query) async {
    return SearchResponce(285, WeatherType.clear);
  }

  @override
  Future<SearchResponce> getWeatherCoords(SearchQueryCoords query) async {
    return SearchResponce(285, WeatherType.clear);
  }
}