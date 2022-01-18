import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/provider/movie_list_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late int listenerCallCount;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieListNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    provider = MovieListNotifier(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    )..addListener(() {
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

  group('now playing movies', () {
    test(
      'initial state should be Empty',
      () {
        expect(provider.nowPlayingState, equals(RequestState.empty));
      },
    );

    test(
      'should get movies data from the usecase',
      () async {
        // arrange
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        provider.fetchNowPlayingMovies();

        // assert
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    test(
      'should change state to loading when usecase is called',
      () {
        // arrange
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        provider.fetchNowPlayingMovies();

        // assert
        expect(provider.nowPlayingState, equals(RequestState.loading));
      },
    );

    test(
      'should change movies when data is gotten successfully',
      () async {
        // arrange
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        await provider.fetchNowPlayingMovies();

        // assert
        expect(provider.nowPlayingState, equals(RequestState.loaded));
        expect(provider.nowPlayingMovies, equals(tMovieList));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchNowPlayingMovies();

        // assert
        expect(provider.nowPlayingState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });

  group('popular movies', () {
    test(
      'initial state should be Empty',
      () {
        expect(provider.popularMoviesState, equals(RequestState.empty));
      },
    );

    test(
      'should get movies data from the usecase',
      () async {
        // arrange
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        provider.fetchPopularMovies();

        // assert
        verify(mockGetPopularMovies.execute());
      },
    );

    test(
      'should change state to loading when usecase is called',
      () {
        // arrange
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        provider.fetchPopularMovies();

        // assert
        expect(provider.popularMoviesState, equals(RequestState.loading));
      },
    );

    test(
      'should change movies when data is gotten successfully',
      () async {
        // arrange
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        await provider.fetchPopularMovies();

        // assert
        expect(provider.popularMoviesState, equals(RequestState.loaded));
        expect(provider.popularMovies, equals(tMovieList));
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
        await provider.fetchPopularMovies();

        // assert
        expect(provider.popularMoviesState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });

  group('top rated movies', () {
    test(
      'initial state should be Empty',
      () {
        expect(provider.topRatedMoviesState, equals(RequestState.empty));
      },
    );

    test(
      'should get movies data from the usecase',
      () async {
        // arrange
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        provider.fetchTopRatedMovies();

        // assert
        verify(mockGetTopRatedMovies.execute());
      },
    );

    test(
      'should change state to loading when usecase is called',
      () {
        // arrange
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        provider.fetchTopRatedMovies();

        // assert
        expect(provider.topRatedMoviesState, equals(RequestState.loading));
      },
    );

    test(
      'should change movies when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        // act
        await provider.fetchTopRatedMovies();

        // assert
        expect(provider.topRatedMoviesState, equals(RequestState.loaded));
        expect(provider.topRatedMovies, equals(tMovieList));
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
        await provider.fetchTopRatedMovies();

        // assert
        expect(provider.topRatedMoviesState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
