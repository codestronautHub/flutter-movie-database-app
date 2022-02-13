import 'dart:convert';
import 'package:core/utils/exception.dart';
import 'package:core/utils/urls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/models/media_image_model.dart';
import 'package:movie/data/models/movie_detail_response.dart';
import 'package:movie/data/models/movie_response.dart';

import '../../helpers/json_reader.dart';
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
      json.decode(readJson('helpers/dummy_responses/now_playing_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.nowPlayingMovies))).thenAnswer(
            (_) async => http.Response(
                readJson('helpers/dummy_responses/now_playing_movie.json'),
                200));

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
      json.decode(
          readJson('helpers/dummy_responses/popular_top_rated_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.popularMovies))).thenAnswer(
            (_) async => http.Response(
                readJson(
                    'helpers/dummy_responses/popular_top_rated_movie.json'),
                200));

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
      json.decode(
          readJson('helpers/dummy_responses/popular_top_rated_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.topRatedMovies))).thenAnswer(
            (_) async => http.Response(
                readJson(
                    'helpers/dummy_responses/popular_top_rated_movie.json'),
                200));

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
    const tId = 1;
    final tMovieDetail = MovieDetailResponse.fromJson(
      json.decode(readJson('helpers/dummy_responses/movie_detail.json')),
    );

    test(
      'should return movie detail when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieDetail(tId)))).thenAnswer(
            (_) async => http.Response(
                readJson('helpers/dummy_responses/movie_detail.json'), 200));

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
    const tId = 1;
    final tMovieList = MovieResponse.fromJson(
      json.decode(
          readJson('helpers/dummy_responses/movie_recommendations.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieRecommendations(tId))))
            .thenAnswer((_) async => http.Response(
                readJson('helpers/dummy_responses/movie_recommendations.json'),
                200));

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
    const tQuery = 'Spiderman';
    final tSearchResult = MovieResponse.fromJson(
      json.decode(readJson('helpers/dummy_responses/search_movie.json')),
    ).movieList;

    test(
      'should return list of movie model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.searchMovies(tQuery))))
            .thenAnswer((_) async => http.Response(
                readJson('helpers/dummy_responses/search_movie.json'), 200));

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
    const tId = 1;
    final tMovieImages = MediaImageModel.fromJson(
      json.decode(readJson('helpers/dummy_responses/images.json')),
    );

    test(
      'should return movie images when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(Urls.movieImages(tId)))).thenAnswer(
            (_) async => http.Response(
                readJson('helpers/dummy_responses/images.json'), 200));

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
