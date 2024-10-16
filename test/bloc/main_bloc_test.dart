import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youbloom/bloc/main_bloc.dart'; 
import 'package:youbloom/events/main_event.dart';
import 'package:youbloom/states/main_state.dart';
import 'package:youbloom/models/concert_model.dart';


class MockDio extends Mock implements Dio {}

void main() {
  group('MainBloc', () {
    late MainBloc mainBloc;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      mainBloc = MainBloc(mockDio); 
    });

    tearDown(() {
      mainBloc.close();
    });

    test('initial state is MainLoading', () {
      expect(mainBloc.state, equals(MainLoading()));
    });

    blocTest<MainBloc, MainState>(
      'emits [MainLoading, MainLoaded] when fetching events is successful',
      build: () {
        when(mockDio.get('https://ellearz.github.io/youbloom/concert_data.json')).thenAnswer((_) async => Response(
              data: [
                {
                  'title': 'Concert 1',
                  'date': '2024-10-16',
                  'description': 'Description of Concert 1',
                  'photo': 'path/to/photo.jpg',
                },
                {
                  'title': 'Concert 2',
                  'date': '2024-10-17',
                  'description': 'Description of Concert 2',
                  'photo': 'path/to/photo2.jpg',
                },
              ],
              statusCode: 200,
              requestOptions: RequestOptions(path: 'https://ellearz.github.io/youbloom/concert_data.json'),
            ));
        return mainBloc;
      },
      act: (bloc) => bloc.add(FetchEvents()),
      expect: () => [
        MainLoading(),
        MainLoaded([
          Concert(
            title: 'Concert 1',
            date: '2024-10-16',
            description: 'Description of Concert 1',
            imagePath: 'path/to/photo.jpg',
          ),
          Concert(
            title: 'Concert 2',
            date: '2024-10-17',
            description: 'Description of Concert 2',
            imagePath: 'path/to/photo2.jpg',
          ),
        ]),
      ],
    );

    blocTest<MainBloc, MainState>(
      'emits [MainLoading, MainError] when fetching events fails',
      build: () {
        when(mockDio.get('https://ellearz.github.io/youbloom/concert_data.json')).thenThrow(Exception('Network Error'));
        return mainBloc;
      },
      act: (bloc) => bloc.add(FetchEvents()),
      expect: () => [
        MainLoading(),
        MainError('Failed to fetch data'),
      ],
    );

    blocTest<MainBloc, MainState>(
      'emits [MainLoaded] when search is performed',
      build: () {
        mainBloc.allConcerts = [
          Concert(
            title: 'Concert 1',
            date: '2024-10-16',
            description: 'Description of Concert 1',
            imagePath: 'path/to/photo.jpg',
          ),
          Concert(
            title: 'Concert 2',
            date: '2024-10-17',
            description: 'Description of Concert 2',
            imagePath: 'path/to/photo2.jpg',
          ),
        ];
        return mainBloc;
      },
      act: (bloc) => bloc.add(SearchEvents('1')),
      expect: () => [
        MainLoaded([
          Concert(
            title: 'Concert 1',
            date: '2024-10-16',
            description: 'Description of Concert 1',
            imagePath: 'path/to/photo.jpg',
          ),
        ]),
      ],
    );
  });
}

