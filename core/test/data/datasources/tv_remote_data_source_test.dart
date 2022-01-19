import 'dart:convert';

import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/models/media_image_model.dart';
import 'package:core/data/models/tv_detail_response.dart';
import 'package:core/data/models/tv_response.dart';
import 'package:core/data/models/tv_season_episode_response.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/urls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late TvRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tTvList = TvResponse.fromJson(
    json.decode(readJson('dummy_data/tv.json')),
  ).tvList;

  group('get on the air tvs', () {
    test(
      'should return list of tv model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.onTheAirTvs))).thenAnswer(
            (_) async => http.Response(readJson('dummy_data/tv.json'), 200));

        // act
        final result = await dataSource.getOnTheAirTvs();

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.onTheAirTvs)))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getOnTheAirTvs();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get popular tvs', () {
    test(
      'should return list of tv model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.popularTvs))).thenAnswer(
            (_) async => http.Response(readJson('dummy_data/tv.json'), 200));

        // act
        final result = await dataSource.getPopularTvs();

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.popularTvs)))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getPopularTvs();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get top rated tvs', () {
    test(
      'should return list of tv model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.topRatedTvs))).thenAnswer(
            (_) async => http.Response(readJson('dummy_data/tv.json'), 200));

        // act
        final result = await dataSource.getTopRatedTvs();

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.topRatedTvs)))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getTopRatedTvs();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv detail', () {
    const tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
      json.decode(readJson('dummy_data/tv_detail.json')),
    );

    test(
      'should return tv detail when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvDetail(tId)))).thenAnswer(
            (_) async =>
                http.Response(readJson('dummy_data/tv_detail.json'), 200));

        // act
        final result = await dataSource.getTvDetail(tId);

        // assert
        expect(result, equals(tTvDetail));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvDetail(tId))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getTvDetail(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv season episodes', () {
    const tId = 1;
    const tSeasonNumber = 1;
    final tTvSeasonEpisodes = TvSeasonEpisodeResponse.fromJson(
      json.decode(readJson('dummy_data/tv_season.json')),
    ).tvEpisodes;

    test(
      'should return tv season episodes when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvSeasons(tId, tSeasonNumber))))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy_data/tv_season.json'), 200));

        // act
        final result = await dataSource.getTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        expect(result, equals(tTvSeasonEpisodes));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvSeasons(tId, tSeasonNumber))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getTvSeasonEpisodes(tId, tSeasonNumber);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv recommendations', () {
    const tId = 1;
    final tTvList = TvResponse.fromJson(
      json.decode(readJson('dummy_data/tv_recommendations.json')),
    ).tvList;

    test(
      'should return list of tv model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvRecommendations(tId))))
            .thenAnswer((_) async => http.Response(
                readJson('dummy_data/tv_recommendations.json'), 200));

        // act
        final result = await dataSource.getTvRecommendations(tId);

        // assert
        expect(result, equals(tTvList));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvRecommendations(tId))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getTvRecommendations(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('search a tv', () {
    const tQuery = 'Arcane';
    final tSearchResult = TvResponse.fromJson(
      json.decode(readJson('dummy_data/search_tv.json')),
    ).tvList;

    test(
      'should return list of tv model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.searchTvs(tQuery)))).thenAnswer(
            (_) async =>
                http.Response(readJson('dummy_data/search_tv.json'), 200));

        // act
        final result = await dataSource.searchTvs(tQuery);

        // assert
        expect(result, equals(tSearchResult));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.searchTvs(tQuery))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.searchTvs(tQuery);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv images', () {
    const tId = 1;
    final tTvImages = MediaImageModel.fromJson(
      json.decode(readJson('dummy_data/images.json')),
    );

    test(
      'should return tv images when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvImages(tId)))).thenAnswer(
            (_) async =>
                http.Response(readJson('dummy_data/images.json'), 200));

        // act
        final result = await dataSource.getTvImages(tId);

        // assert
        expect(result, equals(tTvImages));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.tvImages(tId))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getTvImages(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
