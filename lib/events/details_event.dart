
abstract class DetailsEvent {}

class FetchDetailsEvent extends DetailsEvent {
  final String concertTitle;

  FetchDetailsEvent(this.concertTitle);
}
