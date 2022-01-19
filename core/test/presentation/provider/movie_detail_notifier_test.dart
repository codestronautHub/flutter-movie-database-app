import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchlistStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late int listenerCallCount;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MovieDetailNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    provider = MovieDetailNotifier(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  const tId = 1;

  final tMovie = Movie(
    backdropPath: '/path.jpg',
    genreIds: const [1, 2, 3, 4],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovies = <Movie>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('movie detail', () {
    test(
      'should get movie detail data from the usecase',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    test(
      'should change state to loading when usecase is called',
      () {
        // arrange
        _arrangeUsecase();

        // act
        provider.fetchMovieDetail(tId);

        // assert
        expect(provider.movieState, equals(RequestState.loading));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change movie when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        expect(provider.movieState, equals(RequestState.loaded));
        expect(provider.movie, equals(testMovieDetail));
        expect(listenerCallCount, equals(3));
      },
    );

    test(
      'should change recommendation movies when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        expect(provider.movieState, equals(RequestState.loaded));
        expect(provider.recommendations, equals(tMovies));
      },
    );

    test('should return server failure when error', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));

      // act
      await provider.fetchMovieDetail(tId);

      // assert
      expect(provider.movieState, equals(RequestState.error));
      expect(provider.message, equals('Server failure'));
      expect(listenerCallCount, equals(2));
    });
  });

  group('get movie recommendations', () {
    test(
      'should get movie recommendations data from the usecase',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        verify(mockGetMovieRecommendations.execute(tId));
        expect(provider.recommendations, equals(tMovies));
      },
    );

    test(
      'should change recommendation state when data is gotten successfully',
      () async {
        // arrange
        _arrangeUsecase();

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        expect(provider.recommendationsState, equals(RequestState.loaded));
        expect(provider.recommendations, equals(tMovies));
      },
    );

    test(
      'should change error message when request in unsuccessful',
      () async {
        // arrange
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));

        // act
        await provider.fetchMovieDetail(tId);

        // assert
        expect(provider.recommendationsState, equals(RequestState.error));
        expect(provider.message, equals('Failed'));
      },
    );
  });

  group('movie watchlist', () {
    test(
      'should get the watchlist status',
      () async {
        // arrange
        when(mockGetWatchlistStatus.executeMovie(1))
            .thenAnswer((_) async => true);

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
        when(mockSaveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => true);

        // act
        await provider.addToWatchlist(testMovieDetail);

        // assert
        verify(mockSaveWatchlist.executeMovie(testMovieDetail));
      },
    );

    test(
      'should execute remove watchlist when function called',
      () async {
        // arrange
        when(mockRemoveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => false);

        // act
        await provider.removeFromWatchlist(testMovieDetail);

        // assert
        verify(mockRemoveWatchlist.executeMovie(testMovieDetail));
      },
    );

    test(
      'should change watchlist status when adding watchlist success',
      () async {
        // arrange
        when(mockSaveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to watchlist'));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => true);

        // act
        await provider.addToWatchlist(testMovieDetail);

        // assert
        verify(mockGetWatchlistStatus.executeMovie(testMovieDetail.id));
        expect(provider.isAddedToWatchlist, equals(true));
        expect(provider.watchlistMessage, equals('Added to watchlist'));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change watchlist message when adding watchlist failed',
      () async {
        // arrange
        when(mockSaveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => false);

        // act
        await provider.addToWatchlist(testMovieDetail);

        // assert
        expect(provider.watchlistMessage, equals('Failed'));
        expect(listenerCallCount, equals(1));
      },
    );
  });
}
