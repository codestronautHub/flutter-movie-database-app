import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../helpers/json_reader.dart';

void main() {
  const tTvModel = TvModel(
    backdropPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'Name',
    overview: 'Overview',
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTvResponseModel = TvResponse(
    tvList: <TvModel>[tTvModel],
  );

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_responses/tv.json'),
        );

        // act
        final result = TvResponse.fromJson(jsonMap);

        // assert
        expect(result, equals(tTvResponseModel));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tTvResponseModel.toJson();

        // assert
        final expectedJsonMap = {
          'results': [
            {
              'backdrop_path': '/path.jpg',
              'first_air_date': '2022-01-01',
              'genre_ids': [1, 2, 3, 4],
              'id': 1,
              'name': 'Name',
              'overview': 'Overview',
              'poster_path': '/path.jpg',
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
