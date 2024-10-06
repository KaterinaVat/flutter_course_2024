abstract class SearchQuery {}

class SearchQueryByCity extends SearchQuery {
  final String city;

  SearchQueryByCity(this.city);
}

class SearchQueryByCoords extends SearchQuery {
  final double latitude;
  final double longitude;

  SearchQueryByCoords(this.latitude, this.longitude);
}