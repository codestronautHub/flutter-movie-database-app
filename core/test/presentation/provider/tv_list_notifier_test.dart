import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_on_the_air_tvs.dart';
import 'package:core/domain/usecases/get_popular_tvs.dart';
import 'package:core/domain/usecases/get_top_rated_tvs.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late int listenerCallCount;
  late MockGetOnTheAirTvs mockGetOnTheAirTvs;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;
  late TvListNotifier provider;

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
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  group('on the air tvs', () {
    test(
      'initial state should be empty',
      () {
        expect(provider.onTheAirTvsState, equals(RequestState.empty));
      },
    );

    test(
      'should get tvs data from the usecase',
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
      'should change state to loading when usecase is called',
      () async {
        // arrange
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchOnTheAirTvs();

        // assert
        expect(provider.onTheAirTvsState, equals(RequestState.loading));
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
        expect(provider.onTheAirTvsState, equals(RequestState.loaded));
        expect(provider.onTheAirTvs, equals(tTvList));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetOnTheAirTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchOnTheAirTvs();

        // assert
        expect(provider.onTheAirTvsState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });

  group('popular tvs', () {
    test(
      'initial state should be empty',
      () {
        expect(provider.popularTvsState, equals(RequestState.empty));
      },
    );

    test(
      'should get tvs data from the usecase',
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
      'should change state to loading when usecase is called',
      () async {
        // arrange
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchPopularTvs();

        // assert
        expect(provider.popularTvsState, equals(RequestState.loading));
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
        expect(provider.popularTvsState, equals(RequestState.loaded));
        expect(provider.popularTvs, equals(tTvList));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchPopularTvs();

        // assert
        expect(provider.popularTvsState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });

  group('top rated tvs', () {
    test(
      'initial state should be empty',
      () {
        expect(provider.topRatedTvsState, equals(RequestState.empty));
      },
    );

    test(
      'should get tvs data from the usecase',
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
      'should change state to loading when usecase is called',
      () async {
        // arrange
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvList));

        // act
        provider.fetchTopRatedTvs();

        // assert
        expect(provider.topRatedTvsState, equals(RequestState.loading));
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
        expect(provider.topRatedTvsState, equals(RequestState.loaded));
        expect(provider.topRatedTvs, equals(tTvList));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchTopRatedTvs();

        // assert
        expect(provider.topRatedTvsState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
