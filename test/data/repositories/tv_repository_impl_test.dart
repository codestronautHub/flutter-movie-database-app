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
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  // TODO: add MockTvLocalDataSource

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    // TODO: add MockTvLocalDataSource initialization
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      // TODO: add MockTvLocalDataSource dependency
    );
  });

  final tTvModel = TvModel(
    backdropPath: '/35SS0nlBhu28cSe7TiO3ZiywZhl.jpg',
    firstAirDate: '2018-05-02',
    genreIds: [10759, 18],
    id: 77169,
    name: 'Cobra Kai',
    originalName: 'Cobra Kai',
    overview:
        'This Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.',
    popularity: 3389.158,
    posterPath: '/6POBWybSBDBKjSs1VAQcnQC1qyt.jpg',
    voteAverage: 8.1,
    voteCount: 3752,
  );

  final tTv = Tv(
    backdropPath: '/35SS0nlBhu28cSe7TiO3ZiywZhl.jpg',
    firstAirDate: '2018-05-02',
    genreIds: [10759, 18],
    id: 77169,
    name: 'Cobra Kai',
    originalName: 'Cobra Kai',
    overview:
        'This Karate Kid sequel series picks up 30 years after the events of the 1984 All Valley Karate Tournament and finds Johnny Lawrence on the hunt for redemption by reopening the infamous Cobra Kai karate dojo. This reignites his old rivalry with the successful Daniel LaRusso, who has been working to maintain the balance in his life without mentor Mr. Miyagi.',
    popularity: 3389.158,
    posterPath: '/6POBWybSBDBKjSs1VAQcnQC1qyt.jpg',
    voteAverage: 8.1,
    voteCount: 3752,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('On The Air Tvs', () {
    test(
      'should return tv list when call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getOnTheAirTvs())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getOnTheAirTvs();

        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
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
      'should return connection failure when the device is not connected to internet',
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
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });

  group('Popular Tvs', () {
    test(
      'should return tv list when call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getPopularTvs())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getPopularTvs();

        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
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
      'should return connection failure when the device is not connected to internet',
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
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });

  group('Top Rated Tvs', () {
    test(
      'should return tv list when call to remote data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getTopRatedTvs())
            .thenAnswer((_) async => tTvModelList);

        // act
        final result = await repository.getTopRatedTvs();

        // assert
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
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
      'should return connection failure when the device is not connected to internet',
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
            equals(
                Left(ConnectionFailure('Failed to connect to the network'))));
      },
    );
  });
}
