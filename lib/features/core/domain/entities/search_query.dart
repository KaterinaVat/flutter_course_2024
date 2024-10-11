// данный класс будет хранить значение города для которого будет выполняться поиск
abstract class SearchQuery{}

class SearchQueryCity extends SearchQuery{
  final String city;

  SearchQueryCity(this.city);
}


// данный класс будет хранить значение координат широты и долготы города для которого будет выполняться поиск
class SearchQueryCoords  extends SearchQuery {
  final double x;
  final double y;
  SearchQueryCoords(this.x, this.y);
}