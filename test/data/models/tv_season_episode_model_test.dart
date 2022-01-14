import 'package:ditonton/data/models/tv_season_episode_model.dart';
import 'package:ditonton/domain/entities/tv_season_episode.dart';
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

  test(
    'should be a subclass of tv episode entity',
    () async {
      // assert
      final result = tTvEpisodeModel.toEntity();
      expect(result, equals(tTvEpisode));
    },
  );
}
