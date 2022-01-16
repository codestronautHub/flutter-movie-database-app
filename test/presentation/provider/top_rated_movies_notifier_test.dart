import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late int listenerCallCount;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesNotifier notifier;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    notifier = TopRatedMoviesNotifier(getTopRatedMovies: mockGetTopRatedMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = Movie(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test(
    'should change state to loading when usecase is called',
    () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));

      // act
      notifier.fetchTopRatedMovies();

      // assert
      expect(notifier.state, equals(RequestState.Loading));
      expect(listenerCallCount, equals(1));
    },
  );

  test(
    'should change movies when data is gotten successfully',
    () async {
      // arrange
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));

      // act
      await notifier.fetchTopRatedMovies();

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
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));

      // act
      await notifier.fetchTopRatedMovies();

      // assert
      expect(notifier.state, equals(RequestState.Error));
      expect(notifier.message, equals('Server failure'));
      expect(listenerCallCount, equals(2));
    },
  );
}
