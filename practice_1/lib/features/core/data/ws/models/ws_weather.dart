class WSWeather {
  final int temp;
  final String type;

  const WSWeather(this.temp, this.type);

  @override
  String toString() {
    return 'WSWeather{temp: $temp, type: $type}';
  }

}