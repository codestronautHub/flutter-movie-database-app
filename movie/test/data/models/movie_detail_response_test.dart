import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_response.dart';
import 'package:movie/domain/entities/movie_detail.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tMovieDetailResponse = MovieDetailResponse(
    backdropPath: '/path.jpg',
    genres: [GenreModel(id: 1, name: 'Genre 1')],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    runtime: 100,
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
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
      'should be a subclass of movie detail entity',
      () async {
        // assert
        final result = tMovieDetailResponse.toEntity();
        expect(result, equals(tMovieDetail));
      },
    );
  });

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_responses/movie_detail.json'),
        );

        // act
        final result = MovieDetailResponse.fromJson(jsonMap);

        // assert
        expect(result, equals(tMovieDetailResponse));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tMovieDetailResponse.toJson();

        // assert
        final expectedJsonMap = {
          'backdrop_path': '/path.jpg',
          'genres': [
            {'id': 1, 'name': 'Genre 1'}
          ],
          'id': 1,
          'overview': 'Overview',
          'poster_path': '/path.jpg',
          'release_date': '2022-01-01',
          'runtime': 100,
          'title': 'Title',
          'vote_average': 1.0,
          'vote_count': 1,
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
