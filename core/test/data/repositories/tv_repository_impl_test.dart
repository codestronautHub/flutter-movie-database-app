import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/media_image_model.dart';
import 'package:core/data/models/tv_detail_response.dart';
import 'package:core/data/models/tv_season_episode_model.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  late TvRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvModel = TvModel(
    backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
    firstAirDate: '2021-11-06',
    genreIds: [16, 10765, 10759, 18],
    id: 94605,
    name: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
    voteAverage: 9.1,
    voteCount: 1451,
  );

  final tTv = Tv(
    backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
    firstAirDate: '2021-11-06',
    genreIds: const [16, 10765, 10759, 18],
    id: 94605,
    name: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
    voteAverage: 9.1,
    voteCount: 1451,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('on the air tvs', () {
    test(
      'should return tv list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvs())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getOnTheAirTvs();

        // assert
        verify(mockRemoteDataSource.getOnTheAirTvs());
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvs())
            .thenThrow(ServerException());

        // act
        final result = await repository.getOnTheAirTvs();

        // assert
        verify(mockRemoteDataSource.getOnTheAirTvs());
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvs()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getOnTheAirTvs();

        // assert
        verify(mockRemoteDataSource.getOnTheAirTvs());
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Popular Tvs', () {
    test(
      'should return tv list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvs())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getPopularTvs();

        // assert
        verify(mockRemoteDataSource.getPopularTvs());
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvs()).thenThrow(ServerException());

        // act
        final result = await repository.getPopularTvs();

        // assert
        verify(mockRemoteDataSource.getPopularTvs());
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvs()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getPopularTvs();

        // assert
        verify(mockRemoteDataSource.getPopularTvs());
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Top Rated Tvs', () {
    test(
      'should return tv list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvs())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getTopRatedTvs();

        // assert
        verify(mockRemoteDataSource.getTopRatedTvs());
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvs())
            .thenThrow(ServerException());

        // act
        final result = await repository.getTopRatedTvs();

        // assert
        verify(mockRemoteDataSource.getTopRatedTvs());
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvs()).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTopRatedTvs();

        // assert
        verify(mockRemoteDataSource.getTopRatedTvs());
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get tv detail', () {
    const tId = 1;
    const tTvDetailModel = TvDetailResponse(
      backdropPath: '/path.jpg',
      episodeRunTime: [100],
      firstAirDate: '2022-01-01',
      genres: [GenreModel(id: 1, name: 'Genre 1')],
      id: 1,
      name: 'Name',
      numberOfSeasons: 1,
      overview: 'Overview',
      posterPath: '/path.jpg',
      voteAverage: 1.0,
      voteCount: 1,
    );

    test(
      'should return tv detail when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenAnswer((_) async => tTvDetailModel);

        // act
        final result = await repository.getTvDetail(tId);

        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Right(testTvDetail)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenThrow(ServerException());

        // act
        final result = await repository.getTvDetail(tId);

        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTvDetail(tId);

        // assert
        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get tv season episodes', () {
    const tId = 1;
    const tSeasonNumber = 1;
    final tTvSeasonEpisodes = <TvSeasonEpisodeModel>[];

    test(
      'should return tv season episodes when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvSeasonEpisodes(tId, tSeasonNumber))
            .thenAnswer((_) async => tTvSeasonEpisodes);

        // act
        final result = await repository.getTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        verify(mockRemoteDataSource.getTvSeasonEpisodes(tId, tSeasonNumber));
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvSeasonEpisodes));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvSeasonEpisodes(tId, tSeasonNumber))
            .thenThrow(ServerException());

        // act
        final result = await repository.getTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        verify(mockRemoteDataSource.getTvSeasonEpisodes(tId, tSeasonNumber));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvSeasonEpisodes(tId, tSeasonNumber))
            .thenThrow(
                const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        verify(mockRemoteDataSource.getTvSeasonEpisodes(tId, tSeasonNumber));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get tv recommendations', () {
    const tId = 1;
    final tTvList = <TvModel>[];

    test(
      'should return tv list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenAnswer((_) async => tTvList);

        // act
        final result = await repository.getTvRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId))
            .thenThrow(ServerException());

        // act
        final result = await repository.getTvRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvRecommendations(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTvRecommendations(tId);

        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('search a movie', () {
    const tQuery = 'Arcane';

    test(
      'should return tv list when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTvs(tQuery))
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.searchTvs(tQuery);

        // assert
        verify(mockRemoteDataSource.searchTvs(tQuery));
        /* 
          workaround to test List in Right.
          Issue: https://github.com/spebbe/dartz/issues/80 
        */
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvList));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTvs(tQuery))
            .thenThrow(ServerException());

        // act
        final result = await repository.searchTvs(tQuery);

        // assert
        verify(mockRemoteDataSource.searchTvs(tQuery));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTvs(tQuery)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.searchTvs(tQuery);

        // assert
        verify(mockRemoteDataSource.searchTvs(tQuery));
        expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get tv images', () {
    const tId = 1;
    const tTvImages = MediaImageModel(
      id: 1,
      backdropPaths: ['/path.jpg'],
      logoPaths: ['/path.jpg'],
      posterPaths: ['/path.jpg'],
    );

    test(
      'should return tv images when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvImages(tId))
            .thenAnswer((_) async => tTvImages);

        // act
        final result = await repository.getTvImages(tId);

        // assert
        verify(mockRemoteDataSource.getTvImages(tId));
        expect(result, equals(const Right(testImages)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvImages(tId))
            .thenThrow(ServerException());

        // act
        final result = await repository.getTvImages(tId);

        // assert
        verify(mockRemoteDataSource.getTvImages(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTvImages(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTvImages(tId);

        // assert
        verify(mockRemoteDataSource.getTvImages(tId));
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
      'should return success message when saving is successful',
      () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testTvTable))
            .thenAnswer((_) async => 'Added to watchlist');

        // act
        final result = await repository.saveWatchlist(testTvDetail);

        // assert
        verify(mockLocalDataSource.insertWatchlist(testTvTable));
        expect(result, equals(const Right('Added to watchlist')));
      },
    );

    test(
      'should return database failure when saving unsuccessful',
      () async {
        // arrange
        when(mockLocalDataSource.insertWatchlist(testTvTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));

        // act
        final result = await repository.saveWatchlist(testTvDetail);

        // assert
        verify(mockLocalDataSource.insertWatchlist(testTvTable));
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
        when(mockLocalDataSource.removeWatchlist(testTvTable))
            .thenAnswer((_) async => 'Removed from watchlist');

        // act
        final result = await repository.removeWatchlist(testTvDetail);

        // assert
        verify(mockLocalDataSource.removeWatchlist(testTvTable));
        expect(result, equals(const Right('Removed from watchlist')));
      },
    );

    test(
      'should return database failure when remove unsuccessful',
      () async {
        // arrange
        when(mockLocalDataSource.removeWatchlist(testTvTable))
            .thenThrow(DatabaseException('Failed to remove watchlist'));

        // act
        final result = await repository.removeWatchlist(testTvDetail);

        // assert
        verify(mockLocalDataSource.removeWatchlist(testTvTable));
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
        when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);

        // act
        final result = await repository.isAddedToWatchlist(tId);

        // assert
        verify(mockLocalDataSource.getTvById(tId));
        expect(result, equals(false));
      },
    );
  });

  group('get watchlist tvs', () {
    test(
      'should return list of tvs from database',
      () async {
        // arrange
        when(mockLocalDataSource.getWatchlistTvs())
            .thenAnswer((_) async => [testTvTable]);

        // act
        final result = await repository.getWatchlistTvs();

        // assert
        verify(mockLocalDataSource.getWatchlistTvs());
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals([testWatchlistTv]));
      },
    );
  });
}
