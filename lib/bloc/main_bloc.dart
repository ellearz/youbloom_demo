import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloom/events/main_event.dart';
import 'package:youbloom/states/main_state.dart';
import 'package:youbloom/models/concert_model.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final Dio dio;
  List<Concert> allConcerts = [];
  MainBloc(this.dio) : super(MainLoading()) {
    on<FetchEvents>((event, emit) async {
      emit(MainLoading());
      try {
        final response = await dio.get('https://ellearz.github.io/youbloom/concert_data.json');
        
        final concerts = (response.data as List)
            .map((json) => Concert.fromJson(json))
            .toList();
        allConcerts = concerts;
        emit(MainLoaded(concerts));
      } catch (e) {
        print(e);
        emit(MainError('Failed to fetch data'));
      }
    });

    on<SearchEvents>((event, emit) {
      final filteredConcerts = allConcerts.where((concert) {
        return concert.title.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      emit(MainLoaded(filteredConcerts));
    });
  }
}
