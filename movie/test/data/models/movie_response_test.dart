import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/data/models/movie_response.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tMovieModel = MovieModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tMovieResponseModel = MovieResponse(
    movieList: <MovieModel>[tMovieModel],
  );

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_responses/now_playing_movie.json'),
        );

        // act
        final result = MovieResponse.fromJson(jsonMap);

        // assert
        expect(result, equals(tMovieResponseModel));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tMovieResponseModel.toJson();

        // assert
        final expectedJsonMap = {
          'results': [
            {
              'backdrop_path': '/path.jpg',
              'genre_ids': [1, 2, 3, 4],
              'id': 1,
              'overview': 'Overview',
              'poster_path': '/path.jpg',
              'release_date': '2022-01-01',
              'title': 'Title',
              'vote_average': 1.0,
              'vote_count': 1
            }
          ],
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
