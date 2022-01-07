import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late int listenerCallCount;
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesNotifier notifier;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMovies = MockGetPopularMovies();
    notifier = PopularMoviesNotifier(mockGetPopularMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalTitle: 'Original Title',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test(
    'should change state to loading when usecase is called',
    () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));

      // act
      notifier.fetchPopularMovies();

      // assert
      expect(notifier.state, equals(RequestState.Loading));
      expect(listenerCallCount, equals(1));
    },
  );

  test(
    'should change movies when data is gotten successfully',
    () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));

      // act
      await notifier.fetchPopularMovies();

      // assert
      expect(notifier.state, equals(RequestState.Loaded));
      expect(notifier.movies, equals(tMovieList));
      expect(listenerCallCount, equals(2));
    },
  );

  test(
    'should return server failure when error',
    () async {
      // arrange
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));

      // act
      await notifier.fetchPopularMovies();

      // assert
      expect(notifier.state, equals(RequestState.Error));
      expect(notifier.message, equals('Server failure'));
      expect(listenerCallCount, equals(2));
    },
  );
}
