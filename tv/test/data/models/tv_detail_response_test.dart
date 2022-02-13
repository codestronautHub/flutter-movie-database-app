import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_detail_response.dart';
import 'package:tv/domain/entities/tv_detail.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tTvDetailResponse = TvDetailResponse(
    backdropPath: '/path.jpg',
    episodeRunTime: [100],
    firstAirDate: '2022-01-01',
    genres: [GenreModel(id: 1, name: 'Genre 1')],
    id: 1,
    name: 'Name',
    numberOfSeasons: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTvDetail = TvDetail(
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

  group('to entity', () {
    test(
      'should be a subclass of tv detail entity',
      () async {
        // act
        final result = tTvDetailResponse.toEntity();

        // assert
        expect(result, equals(tTvDetail));
      },
    );
  });

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_responses/tv_detail.json'),
        );

        // act
        final result = TvDetailResponse.fromJson(jsonMap);

        // assert
        expect(result, equals(tTvDetailResponse));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tTvDetailResponse.toJson();

        // assert
        final expectedJsonMap = {
          'backdrop_path': '/path.jpg',
          'episode_run_time': [100],
          'first_air_date': '2022-01-01',
          'genres': [
            {'id': 1, 'name': 'Genre 1'}
          ],
          'id': 1,
          'name': 'Name',
          'number_of_seasons': 1,
          'overview': 'Overview',
          'poster_path': '/path.jpg',
          'vote_average': 1.0,
          'vote_count': 1
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
