import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';

import '../../helpers/dummy_objects.dart';

void main() {
  const tMovieTable = MovieTable(
    releaseDate: '2022-01-01',
    id: 1,
    title: 'Title',
    posterPath: '/path.jpg',
    overview: 'Overview',
    voteAverage: 1.0,
  );

  final tMovieWatchlist = Movie.watchlist(
    releaseDate: '2022-01-01',
    id: 1,
    title: 'Title',
    posterPath: '/path.jpg',
    overview: 'Overview',
    voteAverage: 1.0,
  );

  const tMovieDetail = MovieDetail(
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

  group('to entity', () {
    test(
      'should be a subclass of movie watchlist entity',
      () async {
        // act
        final result = tMovieTable.toEntity();

        // assert
        expect(result, equals(tMovieWatchlist));
      },
    );
  });

  group('from entity', () {
    test(
      'should return a movie table from movie detail entity',
      () async {
        // act
        final result = MovieTable.fromEntity(tMovieDetail);

        // assert
        expect(result, equals(tMovieTable));
      },
    );
  });

  group('to map', () {
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tMovieTable.toMap();

        // assert
        expect(result, equals(testMovieMap));
      },
    );
  });

  group('from map', () {
    test(
      'should return a valid model from map',
      () async {
        // act
        final result = MovieTable.fromMap(testMovieMap);

        // assert
        expect(result, equals(tMovieTable));
      },
    );
  });
}
