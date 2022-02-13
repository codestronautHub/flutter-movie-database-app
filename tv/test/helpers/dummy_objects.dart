import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/media_image.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_season_episode.dart';

final testTv = Tv(
  backdropPath: '/rkB4LyZHo1NHXFEDHl9vSD9r1lI.jpg',
  firstAirDate: '2021-11-06',
  genreIds: const [16, 10765, 10759, 18],
  id: 94605,
  name: 'Arcane',
  overview:
      'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
  posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
  voteAverage: 9.1,
  voteCount: 1451,
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  backdropPath: '/path.jpg',
  episodeRunTime: [100],
  firstAirDate: '2022-01-01',
  genres: [Genre(id: 1, name: 'Genre 1')],
  id: 1,
  name: 'Name',
  numberOfSeasons: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

const testTvSeasonEpisode = TvSeasonEpisode(
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

final testTvSeasonEpisodes = [testTvSeasonEpisode];

final testWatchlistTv = Tv.watchList(
  firstAirDate: '2022-01-01',
  id: 1,
  name: 'Name',
  overview: 'Overview',
  posterPath: '/path.jpg',
  voteAverage: 1.0,
);

const testTvTable = TvTable(
  firstAirDate: '2022-01-01',
  id: 1,
  name: 'Name',
  overview: 'Overview',
  posterPath: '/path.jpg',
  voteAverage: 1.0,
);

final testTvMap = {
  'firstAirDate': '2022-01-01',
  'id': 1,
  'name': 'Name',
  'overview': 'Overview',
  'posterPath': '/path.jpg',
  'voteAverage': 1.0,
};

const testImages = MediaImage(
  id: 1,
  backdropPaths: ['/path.jpg'],
  logoPaths: ['/path.jpg'],
  posterPaths: ['/path.jpg'],
);
