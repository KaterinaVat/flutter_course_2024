import 'package:untitled/features/core/domain/entities/search_query.dart';
import 'package:untitled/features/core/domain/entities/search_response.dart';

// класс который содержит только интерфейс
// метод получния погоды по городу

abstract class WeatherRepository {
  Future<SearchResponce> getWeather(SearchQuery query);
}

