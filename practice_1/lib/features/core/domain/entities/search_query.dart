class SearchQuery {
  final String? city;
  final double? latitude;
  final double? longitude;

  const SearchQuery.byCity(this.city) 
    : latitude = null,
      longitude = null;

  const SearchQuery.byCoords(this.latitude, this.longitude)
    : city = null;
}