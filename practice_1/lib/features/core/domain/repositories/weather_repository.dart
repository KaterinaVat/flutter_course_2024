import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';

// класс который содержит только интерфейс
// метод получния погоды по городу

abstract class WeatherRepository {
  Future<SearchResponce> getWeather(SearchQuery query);
}
