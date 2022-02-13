import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/media_image.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

final testMovie = Movie(
  backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
  genreIds: const [28, 12, 878],
  id: 634649,
  overview:
      'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
  posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
  releaseDate: '2021-12-15',
  title: 'Spider-Man: No Way Home',
  voteAverage: 8.4,
  voteCount: 3427,
);

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  backdropPath: '/path.jpg',
  genres: [Genre(id: 1, name: 'Genre 1')],
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  releaseDate: '2022-01-01',
  runtime: 100,
  title: 'Title',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  releaseDate: '2022-01-01',
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  title: 'Title',
  voteAverage: 1.0,
);

const testMovieTable = MovieTable(
  releaseDate: '2022-01-01',
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  title: 'Title',
  voteAverage: 1.0,
);

final testMovieMap = {
  'releaseDate': '2022-01-01',
  'id': 1,
  'overview': 'Overview',
  'posterPath': '/path.jpg',
  'title': 'Title',
  'voteAverage': 1.0,
};

const testImages = MediaImage(
  id: 1,
  backdropPaths: ['/path.jpg'],
  logoPaths: ['/path.jpg'],
  posterPaths: ['/path.jpg'],
);
