import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tTvList = TvResponse.fromJson(
    json.decode(readJson('dummy_data/tv.json')),
  ).tvList;

  group('get On The Air Tvs', () {
    test(
      'should return list of tvs when the response code is 200',
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
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.onTheAirTvs)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getOnTheAirTvs();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Popular Tvs', () {
    test(
      'should return list of tvs when the response code is 200',
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
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.popularTvs)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getPopularTvs();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Top Rated Tvs', () {
    test(
      'should return list of tvs when the response code is 200',
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
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.topRatedTvs)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // act
        final call = dataSource.getTopRatedTvs();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
