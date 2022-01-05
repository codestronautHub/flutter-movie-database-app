import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
  genreIds: [28, 12, 878],
  id: 634649,
  originalTitle: 'Spider-Man: No Way Home',
  overview:
      'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
  popularity: 8817.063,
  posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
  releaseDate: '2021-12-15',
  title: 'Spider-Man: No Way Home',
  video: false,
  voteAverage: 8.4,
  voteCount: 3427,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: '/path.jpg',
  genres: [Genre(id: 1, name: 'Genre 1')],
  id: 1,
  originalTitle: 'Original Title',
  overview: 'Overview',
  posterPath: '/path.jpg',
  releaseDate: '2022-01-01',
  runtime: 100,
  title: 'Title',
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  title: 'Title',
);

final testMovieTable = MovieTable(
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  title: 'Title',
);

final testMovieMap = {
  'id': 1,
  'overview': 'Overview',
  'posterPath': '/path.jpg',
  'title': 'Title',
};
