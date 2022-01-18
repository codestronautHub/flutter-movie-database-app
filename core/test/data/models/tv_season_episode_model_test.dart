import 'package:core/data/models/tv_season_episode_model.dart';
import 'package:core/domain/entities/tv_season_episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvEpisodeModel = TvSeasonEpisodeModel(
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

  final tTvEpisode = TvSeasonEpisode(
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

  group('to entity', () {
    test(
      'should be a subclass of tv episode entity',
      () async {
        // act
        final result = tTvEpisodeModel.toEntity();

        // assert
        expect(result, equals(tTvEpisode));
      },
    );
  });
}
