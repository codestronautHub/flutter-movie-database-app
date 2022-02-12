import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/media_image_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/data/models/movie_detail_response.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/entities/movie.dart';

import '../../helpers/dummy_objects.dart';
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

  const tMovieModel = MovieModel(
    backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
    genreIds: [28, 12, 878],
    id: 634649,
    overview:
        'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
    posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    releaseDate: '2021-12-15',
    title: 'Spider-Man: No Way Home',
    voteAverage: 8.4,
    voteCount: 3427,
  );

  final tMovie = Movie(
    backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
    genreIds: const [28, 12, 878],
    id: 634649,
    overview:
        'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
    posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
    releaseDate: '2021-12-15',
    title: 'Spider-Man: No Way Home',
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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getNowPlayingMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getNowPlayingMovies();

        // assert
        verify(mockRemoteDataSource.getNowPlayingMovies());
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getPopularMovies();

        // assert
        verify(mockRemoteDataSource.getPopularMovies());
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedMovies()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTopRatedMovies();

        // assert
        verify(mockRemoteDataSource.getTopRatedMovies());
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get movie detail', () {
    const tId = 1;
    const tMovieResponse = MovieDetailResponse(
      backdropPath: '/path.jpg',
      genres: [GenreModel(id: 1, name: 'Genre 1')],
      id: 1,
      overview: 'Overview',
      posterPath: '/path.jpg',
      releaseDate: '2022-01-01',
      runtime: 100,
      title: 'Title',
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
        expect(result, equals(const Right(testMovieDetail)));
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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieDetail(tId);

        // assert
        verify(mockRemoteDataSource.getMovieDetail(tId));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get movie recommendations', () {
    const tId = 1;
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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieRecommendations(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('search a movie', () {
    const tQuery = 'Spiderman';

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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.searchMovies(tQuery)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.searchMovies(tQuery);

        // assert
        verify(mockRemoteDataSource.searchMovies(tQuery));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get movie images', () {
    const tId = 1;
    const tMovieImages = MediaImageModel(
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
        expect(result, equals(const Right(testImages)));
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
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getMovieImages(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getMovieImages(tId);

        // assert
        verify(mockRemoteDataSource.getMovieImages(tId));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
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
        expect(result, equals(const Right('Added to watchlist')));
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
          equals(const Left(DatabaseFailure('Failed to add watchlist'))),
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
        expect(result, equals(const Right('Removed from watchlist')));
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
          equals(const Left(DatabaseFailure('Failed to remove watchlist'))),
        );
      },
    );
  });

  group('get watchlist status', () {
    const tId = 1;

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
