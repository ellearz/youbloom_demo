abstract class MainEvent  {}

class FetchEvents extends MainEvent {}

class SearchEvents extends MainEvent {
  final String query;

  SearchEvents(this.query);
}