import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/media_image_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MovieRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
    genreIds: [28, 12, 878],
    id: 634649,
    originalTitle: 'Spider-Man: No Way Home',
    overview:
        'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
    popularity: 8817.063,
    posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    releaseDate: '2021-12-15',
    title: 'Spider-Man: No Way Home',
    video: false,
    voteAverage: 8.4,
    voteCount: 3427,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
    genreIds: [28, 12, 878],
    id: 634649,
    originalTitle: 'Spider-Man: No Way Home',
    overview:
        'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
    popularity: 8817.063,
    posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    releaseDate: '2021-12-15',
    title: 'Spider-Man: No Way Home',
    video: false,
    voteAverage: 8.4,
    voteCount: 3427,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('get now playing movies', () {
    test(
      'should return movie list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tMovieList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenThrow(ServerException());

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies())
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get popular movies', () {
    test(
      'should return movie list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.getPopularMovies();

        // assert
        verify(mockRemoteDataSource.getPopularMovies());
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tMovieList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException());

        // act
        final result = await repository.getPopularMovies();

        // assert
        verify(mockRemoteDataSource.getPopularMovies());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies())
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getPopularMovies();

        // assert
        verify(mockRemoteDataSource.getPopularMovies());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get top rated movies', () {
    test(
      'should return movie list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tMovieList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(ServerException());

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies())
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get movie images', () {
    final tId = 1;
    final tMovieImages = MediaImageModel(
      id: 1,
      backdropPaths: ['/path.jpg'],
      logoPaths: ['/path.jpg'],
      posterPaths: ['/path.jpg'],
    );

    test(
      'should return movie images when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieImages(tId))
            .thenAnswer((_) async => tMovieImages);

        // act
        final result = await repository.getMovieImages(tId);

        // assert
        verify(mockRemoteDataSource.getMovieImages(tId));
        expect(result, equals(Right(testImages)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieImages(tId))
            .thenThrow(ServerException());

        // act
        final result = await repository.getMovieImages(tId);

        // assert
        verify(mockRemoteDataSource.getMovieImages(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieImages(tId))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieImages(tId);

        // assert
        verify(mockRemoteDataSource.getMovieImages(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: '/path.jpg',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Genre 1')],
      homepage: "https://www.google.com",
      id: 1,
      imdbId: 'IMDB 1',
      originalLanguage: 'en',
      originalTitle: 'Original Title',
      overview: 'Overview',
      popularity: 1.0,
      posterPath: '/path.jpg',
      releaseDate: '2022-01-01',
      revenue: 10000,
      runtime: 100,
      status: 'Status',
      tagline: 'Tagline',
      title: 'Title',
      video: false,
      voteAverage: 1.0,
      voteCount: 1,
    );

    test(
      'should return movie detail when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenAnswer((_) async => tMovieResponse);

        // act
        final result = await repository.getMovieDetail(tId);

        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, equals(Right(testMovieDetail)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenThrow(ServerException());

        // act
        final result = await repository.getMovieDetail(tId);

        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieDetail(tId);

        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get movie recommendations', () {
    final tId = 1;
    final tMovieList = <MovieModel>[];

    test(
      'should return movie list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId))
            .thenAnswer((_) async => tMovieList);

        // act
        final result = await repository.getMovieRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tMovieList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId))
            .thenThrow(ServerException());

        // act
        final result = await repository.getMovieRecommendations(tId);

        // assertbuild runner
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('search a movie', () {
    final tQuery = 'Spiderman';

    test(
      'should return movie list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery))
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await repository.searchMovies(tQuery);

        // assert
        verify(mockRemoteDataSource.searchMovies(tQuery));
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tMovieList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery))
            .thenThrow(ServerException());

        // act
        final result = await repository.searchMovies(tQuery);

        // assert
        verify(mockRemoteDataSource.searchMovies(tQuery));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.searchMovies(tQuery);

        // assert
        verify(mockRemoteDataSource.searchMovies(tQuery));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('save watchlist', () {
    test(
      'should return success message when saving successful',
      () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenAnswer((_) async => 'Added to watchlist');

        // act
        final result = await repository.saveWatchlist(testMovieDetail);

        // assert
        verify(mockLocalDataSource.insertWatchlist(testMovieTable));
        expect(result, equals(Right('Added to watchlist')));
      },
    );

    test(
      'should return database failure when saving unsuccessful',
      () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testMovieTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));

        // act
        final result = await repository.saveWatchlist(testMovieDetail);

        // assert
        verify(mockLocalDataSource.insertWatchlist(testMovieTable));
        expect(
          result,
          equals(Left(DatabaseFailure('Failed to add watchlist'))),
        );
      },
    );
  });

  group('remove watchlist', () {
    test(
      'should return success message when remove successful',
      () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(testMovieTable))
            .thenAnswer((_) async => 'Removed from watchlist');

        // act
        final result = await repository.removeWatchlist(testMovieDetail);

        // assert
        verify(mockLocalDataSource.removeWatchlist(testMovieTable));
        expect(result, equals(Right('Removed from watchlist')));
      },
    );

    test(
      'should return database failure when remove unsuccessful',
      () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(testMovieTable))
            .thenThrow(DatabaseException('Failed to remove watchlist'));

        // act
        final result = await repository.removeWatchlist(testMovieDetail);

        // assert
        verify(mockLocalDataSource.removeWatchlist(testMovieTable));
        expect(
          result,
          equals(Left(DatabaseFailure('Failed to remove watchlist'))),
        );
      },
    );
  });

  group('get watchlist status', () {
    final tId = 1;
    test(
      'should return watchlist status whether data is found',
      () async {
        // arrange

        when(mockLocalDataSource.getMovieById(tId))
            .thenAnswer((_) async => null);

        // act
        final result = await repository.isAddedToWatchlist(tId);

        // assert
        verify(mockLocalDataSource.getMovieById(tId));
        expect(result, equals(false));
      },
    );
  });

  group('get watchlist movies', () {
    test(
      'should return list of movies from database',
      () async {
        // arrange
        when(mockLocalDataSource.getWatchlistMovies())
            .thenAnswer((_) async => [testMovieTable]);

        // act
        final result = await repository.getWatchlistMovies();

        // assert
        verify(mockLocalDataSource.getWatchlistMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals([testWatchlistMovie]));
      },
    );
  });
}
