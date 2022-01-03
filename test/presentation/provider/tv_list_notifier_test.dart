import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late TvListNotifier provider;
  late MockGetOnTheAirTvs mockGetOnTheAirTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTvs = MockGetOnTheAirTvs();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    provider = TvListNotifier(
      getOnTheAirTvs: mockGetOnTheAirTvs,
      getPopularTvs: mockGetPopularTvs,
      getTopRatedTvs: mockGetTopRatedTvs,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTv = Tv(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  group('on the air tvs', () {
    test(
      'initialState should be empty',
      () {
        expect(provider.onTheAirTvsState, equals(RequestState.Empty));
      },
    );

    test(
      'should get data from the usecase',
      () async {
        // arrange
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchOnTheAirTvs();

        // assert
        verify(mockGetOnTheAirTvs.execute());
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () async {
        // arrange
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchOnTheAirTvs();

        // assert
        expect(provider.onTheAirTvsState, RequestState.Loading);
      },
    );

    test(
      'should change tvs when data is gotten successfully',
      () async {
        // arrange
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchOnTheAirTvs();

        // assert
        expect(provider.onTheAirTvsState, RequestState.Loaded);
        expect(provider.onTheAirTvs, tTvList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // act
        await provider.fetchOnTheAirTvs();

        // assert
        expect(provider.onTheAirTvsState, RequestState.Error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });

  group('popular tvs', () {
    test(
      'initialState should be empty',
      () {
        expect(provider.popularTvsState, equals(RequestState.Empty));
      },
    );

    test(
      'should get data from the usecase',
      () async {
        // arrange
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchPopularTvs();

        // assert
        verify(mockGetPopularTvs.execute());
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () async {
        // arrange
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchPopularTvs();

        // assert
        expect(provider.popularTvsState, RequestState.Loading);
      },
    );

    test(
      'should change tvs when data is gotten successfully',
      () async {
        // arrange
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchPopularTvs();

        // assert
        expect(provider.popularTvsState, RequestState.Loaded);
        expect(provider.popularTvs, tTvList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // act
        await provider.fetchPopularTvs();

        // assert
        expect(provider.popularTvsState, RequestState.Error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });

  group('top rated tvs', () {
    test(
      'initialState should be empty',
      () {
        expect(provider.topRatedTvsState, equals(RequestState.Empty));
      },
    );

    test(
      'should get data from the usecase',
      () async {
        // arrange
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchTopRatedTvs();

        // assert
        verify(mockGetTopRatedTvs.execute());
      },
    );

    test(
      'should change state to Loading when usecase is called',
      () async {
        // arrange
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchTopRatedTvs();

        // assert
        expect(provider.topRatedTvsState, RequestState.Loading);
      },
    );

    test(
      'should change tvs when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        await provider.fetchTopRatedTvs();

        // assert
        expect(provider.topRatedTvsState, RequestState.Loaded);
        expect(provider.topRatedTvs, tTvList);
        expect(listenerCallCount, 2);
      },
    );

    test(
      'should return error when data is unsuccessful',
      () async {
        // arrange
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // act
        await provider.fetchTopRatedTvs();

        // assert
        expect(provider.topRatedTvsState, RequestState.Error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      },
    );
  });
}
