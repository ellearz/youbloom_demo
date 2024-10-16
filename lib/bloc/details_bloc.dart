import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloom/events/details_event.dart';
import 'package:youbloom/models/concert_model.dart';
import 'package:youbloom/states/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final Dio _dio;

  DetailsBloc(this._dio) : super(DetailsInitial()) {

    on<FetchDetailsEvent>((event, emit) async {
      emit(DetailsLoading());
      try {
        final response = await _dio.get('https://ellearz.github.io/youbloom/concert_data.json');

        if (response.statusCode == 200) {
          final List<dynamic> data = response.data;
          final concertMap = data.firstWhere(
            (concert) => concert['title'] == event.concertTitle,
            orElse: () => null, 
          );

          if (concertMap != null) {
            emit(DetailsLoaded(Concert.fromJson(concertMap)));
          } else {
            emit(DetailsError('Concert not found'));
          }
        } else {
          emit(DetailsError('Failed to load concert data'));
        }
      } catch (e) {
        emit(DetailsError('Error: ${e.toString()}'));
      }
    });
  }
}
