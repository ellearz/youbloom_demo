import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youbloom/bloc/details_bloc.dart';
import 'package:youbloom/events/details_event.dart';
import 'package:youbloom/states/details_state.dart';


import 'main_bloc_test.dart';

void main() {
  group('DetailsBloc', () {
    late DetailsBloc detailsBloc;
    late Dio dio;

    setUp(() {
      dio = Dio();
      detailsBloc = DetailsBloc(dio);
    });

    test('initial state is DetailsInitial', () {
      expect(detailsBloc.state, DetailsInitial());
    });

    blocTest<DetailsBloc, DetailsState>(
      'emits [DetailsLoading, DetailsLoaded] when concert is found',
      build: () {
        dio = MockDio(); 
        return DetailsBloc(dio);
      },
      act: (bloc) => bloc.add(FetchDetailsEvent('Concert Title')),
      expect: () => [
        DetailsLoading(),
        isA<DetailsLoaded>(),
      ],
    );

    blocTest<DetailsBloc, DetailsState>(
      'emits [DetailsLoading, DetailsError] when concert is not found',
      build: () {
        dio = MockDio(); 
        return DetailsBloc(dio);
      },
      act: (bloc) => bloc.add(FetchDetailsEvent('Unknown Title')),
      expect: () => [
        DetailsLoading(),
        isA<DetailsError>(),
      ],
    );
  });
}

