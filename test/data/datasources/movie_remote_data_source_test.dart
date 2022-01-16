import 'dart:convert';

import 'package:ditonton/common/urls.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/models/media_image_model.dart';
import 'package:ditonton/data/models/movie_detail_response.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late MovieRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get now playing movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/now_playing_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.nowPlayingMovies))).thenAnswer(
            (_) async => http.Response(
                readJson('dummy_data/now_playing_movie.json'), 200));

        // act
        final result = await dataSource.getNowPlayingMovies();

        // assert
        expect(result, equals(tMovieList));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.nowPlayingMovies)))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getNowPlayingMovies();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get popular movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/popular_top_rated_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.popularMovies))).thenAnswer(
            (_) async => http.Response(
                readJson('dummy_data/popular_top_rated_movie.json'), 200));

        // act
        final result = await dataSource.getPopularMovies();

        // assert
        expect(result, equals(tMovieList));
      },
    );

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.popularMovies)))
          .thenAnswer((_) async => http.Response('Not found', 404));

      // act
      final call = dataSource.getPopularMovies();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated movies', () {
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/popular_top_rated_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.topRatedMovies))).thenAnswer(
            (_) async => http.Response(
                readJson('dummy_data/popular_top_rated_movie.json'), 200));

        // act
        final result = await dataSource.getTopRatedMovies();

        // assert
        expect(result, equals(tMovieList));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.topRatedMovies)))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getTopRatedMovies();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
      json.decode(readJson('dummy_data/movie_detail.json')),
    );

    test(
      'should return movie detail when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieDetail(tId)))).thenAnswer(
            (_) async =>
                http.Response(readJson('dummy_data/movie_detail.json'), 200));

        // act
        final result = await dataSource.getMovieDetail(tId);

        // assert
        expect(result, equals(tMovieDetail));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieDetail(tId))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getMovieDetail(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get movie recommendations', () {
    final tId = 1;
    final tMovieList = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/movie_recommendations.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieRecommendations(tId))))
            .thenAnswer((_) async => http.Response(
                readJson('dummy_data/movie_recommendations.json'), 200));

        // act
        final result = await dataSource.getMovieRecommendations(tId);

        // assert
        expect(result, equals(tMovieList));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieRecommendations(tId))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getMovieRecommendations(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('search a movie', () {
    final tQuery = 'Spiderman';
    final tSearchResult = MovieResponse.fromJson(
      json.decode(readJson('dummy_data/search_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.searchMovies(tQuery))))
            .thenAnswer((_) async =>
                http.Response(readJson('dummy_data/search_movie.json'), 200));

        // act
        final result = await dataSource.searchMovies(tQuery);

        // assert
        expect(result, equals(tSearchResult));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.searchMovies(tQuery))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.searchMovies(tQuery);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get movie images', () {
    final tId = 1;
    final tMovieImages = MediaImageModel.fromJson(
      json.decode(readJson('dummy_data/images.json')),
    );

    test(
      'should return movie images when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieImages(tId)))).thenAnswer(
            (_) async =>
                http.Response(readJson('dummy_data/images.json'), 200));

        // act
        final result = await dataSource.getMovieImages(tId);

        // assert
        expect(result, equals(tMovieImages));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieImages(tId))))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // act
        final call = dataSource.getMovieImages(tId);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
