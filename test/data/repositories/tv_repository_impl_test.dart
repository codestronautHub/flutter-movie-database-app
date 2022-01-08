import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRemoteDataSource mockRemoteDataSource;
  // TODO: add MockTvLocalDataSource
  late TvRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    // TODO: add MockTvLocalDataSource initialization
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      // TODO: add MockTvLocalDataSource dependency
    );
  });

  final tTvModel = TvModel(
    backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
    firstAirDate: '2021-11-06',
    genreIds: [16, 10765, 10759, 18],
    id: 94605,
    name: 'Arcane',
    originalName: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    popularity: 663.141,
    posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
    voteAverage: 9.1,
    voteCount: 1451,
  );

  final tTv = Tv(
    backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
    firstAirDate: '2021-11-06',
    genreIds: [16, 10765, 10759, 18],
    id: 94605,
    name: 'Arcane',
    originalName: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    popularity: 663.141,
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
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvs())
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getOnTheAirTvs();

        // assert
        verify(mockRemoteDataSource.getOnTheAirTvs());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
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
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvs())
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getPopularTvs();

        // assert
        verify(mockRemoteDataSource.getPopularTvs());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
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
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvs())
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getTopRatedTvs();

        // assert
        verify(mockRemoteDataSource.getTopRatedTvs());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('search a movie', () {
    final tQuery = 'Arcane';

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
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected',
      () async {
        // arrange
        when(mockRemoteDataSource.searchTvs(tQuery))
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.searchTvs(tQuery);

        // assert
        verify(mockRemoteDataSource.searchTvs(tQuery));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
