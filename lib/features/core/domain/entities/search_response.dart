class SearchResponce {
  final int temp;
  final WeatherType type;

  const SearchResponce(this.temp, this.type);

  @override
  String toString() {
    return 'SearchResponce{temp: $temp, type: $type}';
  }
}


enum WeatherType {clear, rain, cloudy, other, snow, sunny }