import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late int listenerCallCount;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    provider = WatchlistMovieNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  test(
    'should change movies when data is gotten successfully',
    () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));

      // act
      await provider.fetchWatchlistMovies();

      // assert
      expect(provider.watchlistState, equals(RequestState.Loaded));
      expect(provider.watchlistMovies, equals([testWatchlistMovie]));
      expect(listenerCallCount, equals(2));
    },
  );

  test(
    'should return database failure when error',
    () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Can\'t get data')));

      // act
      await provider.fetchWatchlistMovies();

      // assert
      expect(provider.watchlistState, equals(RequestState.Error));
      expect(provider.message, equals('Can\'t get data'));
      expect(listenerCallCount, equals(2));
    },
  );
}
