import 'package:practice_1/features/core/data/debug/weather_repository_debug.dart';
import 'package:practice_1/features/core/data/ws/ws_api.dart';
import 'package:practice_1/features/core/data/ws/weather_repository_ws.dart';
import 'package:practice_1/features/core/presentation/app.dart';



const String version = '0.0.1';
const String url_OSM = 'https://api.openweathermap.org';
const String apiKey_OSM = '8edaa98a088028708c27c0115ce4c10b';

const String url_TM = 'http://api.weatherstack.com';
const String apiKey_TM = '4bf58b2ee069822c7ed103d23fe364e3';

void main(List<String> arguments) async{
  var app = App(WeatherRepositoryWS(WSApi(url_TM, apiKey_TM)));
  app.run();


}