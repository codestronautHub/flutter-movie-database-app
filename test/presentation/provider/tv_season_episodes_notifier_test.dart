import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_season_episode.dart';
import 'package:ditonton/domain/usecases/get_tv_season_episodes.dart';
import 'package:ditonton/presentation/provider/tv_season_episodes_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_episodes_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeasonEpisodes])
void main() {
  late int listenerCallCount;
  late MockGetTvSeasonEpisodes mockGetTvSeasonEpisodes;
  late TvSeasonEpisodesNotifier provider;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeasonEpisodes = MockGetTvSeasonEpisodes();
    provider = TvSeasonEpisodesNotifier(
      getTvSeasonEpisodes: mockGetTvSeasonEpisodes,
    )..addListener(() {
        listenerCallCount++;
      });
  });

  final tId = 1;

  final tSeasonNumber = 1;

  final tTvSeasonEpisode = TvSeasonEpisode(
    airDate: '2022-01-01',
    episodeNumber: 1,
    id: 1,
    name: 'Name',
    overview: 'Overview',
    seasonNumber: 1,
    stillPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvSeasonEpisodes = <TvSeasonEpisode>[tTvSeasonEpisode];

  group('get tv season episodes', () {
    test(
      'should get tv season episodes from the usecase',
      () async {
        // arrange
        when(mockGetTvSeasonEpisodes.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Right(tTvSeasonEpisodes));

        // act
        await provider.fetchTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        verify(mockGetTvSeasonEpisodes.execute(tId, tSeasonNumber));
      },
    );

    test(
      'should change state to loading when the usecase is called',
      () {
        // arrange
        when(mockGetTvSeasonEpisodes.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Right(tTvSeasonEpisodes));

        // act
        provider.fetchTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        expect(provider.seasonEpisodesState, equals(RequestState.Loading));
        expect(listenerCallCount, equals(1));
      },
    );

    test(
      'should change tv season episodes when data is gotten successfully',
      () async {
        // arrange
        when(mockGetTvSeasonEpisodes.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Right(tTvSeasonEpisodes));

        // act
        await provider.fetchTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        expect(provider.seasonEpisodesState, equals(RequestState.Loaded));
        expect(provider.seasonEpisodes, equals(testTvSeasonEpisodes));
        expect(listenerCallCount, equals(2));
      },
    );

    test(
      'should return server failure when error occurred',
      () async {
        // arrange
        when(mockGetTvSeasonEpisodes.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));

        // act
        await provider.fetchTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        expect(provider.seasonEpisodesState, equals(RequestState.Error));
        expect(provider.message, equals('Server failure'));
        expect(listenerCallCount, equals(2));
      },
    );
  });
}
