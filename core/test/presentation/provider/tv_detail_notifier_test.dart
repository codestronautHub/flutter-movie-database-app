import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late int listenerCallCount;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late TvDetailNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatus = MockGetWatchlistStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  const tId = 1;

  final tTv = Tv(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: const [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => const Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('tv detail', () {
    test(
      'should get tv detail data from the usecase',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        verify(mockGetTvDetail.execute(tId));
      },
    );

    test(
      'should change state to loading when usecase is called',
      () {
        // arrange
        _arrangeUsecase();

        // act
        provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, equals(RequestState.loading));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change tv data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, equals(RequestState.loaded));
        expect(provider.tv, equals(testTvDetail));
        expect(listenerCallCount, equals(3));
      },
    );

    test(
      'should change recommendation tvs when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, equals(RequestState.loaded));
        expect(provider.recommendations, equals(tTvs));
      },
    );

    test(
      'should return server failure when error',
      () async {
        // arrange
        when(mockGetTvDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.tvState, equals(RequestState.error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });

  group('get tv recommendations', () {
    test(
      'should get tv recommendations data from the usecase',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        verify(mockGetTvRecommendations.execute(tId));
        expect(provider.recommendations, equals(tTvs));
      },
    );

    test(
      'should change recommendations state when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.recommendationsState, equals(RequestState.loaded));
        expect(provider.recommendations, equals(tTvs));
      },
    );

    test(
      'should change error message when the request is unsuccessful',
      () async {
        // arrange
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => const Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));

        // act
        await provider.fetchTvDetail(tId);

        // assert
        expect(provider.recommendationsState, equals(RequestState.error));
        expect(provider.message, equals('Failed'));
      },
    );
  });

  group('tv watchlist', () {
    test(
      'should get the watchlist status',
      () async {
        // arrange
        when(mockGetWatchListStatus.executeTv(1)).thenAnswer((_) async => true);

        // act
        await provider.loadWatchlistStatus(1);

        // assert
        expect(provider.isAddedToWatchlist, equals(true));
      },
    );

    test(
      'should execute save watchlist when function called',
      () async {
        // arrange
        when(mockSaveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchListStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => true);

        // act
        await provider.addToWatchlist(testTvDetail);

        // assert
        verify(mockSaveWatchlist.executeTv(testTvDetail));
      },
    );

    test(
      'should execute remove watchlist when function called',
      () async {
        // arrange
        when(mockRemoveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchListStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => true);

        // act
        await provider.removeFromWatchlist(testTvDetail);

        // assert
        verify(mockRemoveWatchlist.executeTv(testTvDetail));
      },
    );

    test(
      'should change watchlist status when adding watchlist success',
      () async {
        // arrange
        when(mockSaveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => const Right('Added to watchlist'));
        when(mockGetWatchListStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => true);

        // act
        await provider.addToWatchlist(testTvDetail);

        // assert
        verify(mockGetWatchListStatus.executeTv(testTvDetail.id));
        expect(provider.isAddedToWatchlist, equals(true));
        expect(provider.watchlistMessage, equals('Added to watchlist'));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change watchlist message when adding watchlist failed',
      () async {
        // arrange
        when(mockSaveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => true);

        // act
        await provider.addToWatchlist(testTvDetail);

        // assert
        expect(provider.watchlistMessage, equals('Failed'));
        expect(listenerCallCount, equals(1));
      },
    );
  });
}
