import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/get_watchlist_tvs.dart';
import 'package:core/presentation/provider/watchlist_tv_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late int listenerCallCount;
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late WatchlistTvNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    provider = WatchlistTvNotifier(
      getWatchlistTvs: mockGetWatchlistTvs,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  test(
    'should change tvs when data is gotten successfully',
    () async {
      // arrange
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));

      // act
      await provider.fetchWatchlistTvs();

      // assert
      expect(provider.watchlistState, equals(RequestState.loaded));
      expect(provider.watchlistTvs, equals([testWatchlistTv]));
      expect(listenerCallCount, equals(2));
    },
  );

  test(
    'should return database failure when error occurred',
    () async {
      // arrange
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Can\'t get data')));

      // act
      await provider.fetchWatchlistTvs();

      // assert
      expect(provider.watchlistState, equals(RequestState.error));
      expect(provider.message, equals('Can\'t get data'));
      expect(listenerCallCount, equals(2));
    },
  );
}
