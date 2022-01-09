import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/media_image_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
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

  group('get tv images', () {
    final tId = 1;
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

  group('search a tv', () {
    final tQuery = 'Arcane';
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
}
