import 'dart:convert';

import 'package:core/data/models/media_image_model.dart';
import 'package:core/data/models/tv_detail_response.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/data/models/tv_response.dart';
import 'package:core/data/models/tv_season_episode_model.dart';
import 'package:core/data/models/tv_season_episode_response.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/urls.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTvs();
  Future<List<TvModel>> getPopularTvs();
  Future<List<TvModel>> getTopRatedTvs();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvSeasonEpisodeModel>> getTvSeasonEpisodes(
      int id, int seasonNumber);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchTvs(String query);
  Future<MediaImageModel> getTvImages(int id);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getOnTheAirTvs() async {
    final response = await client.get(Uri.parse(Urls.onTheAirTvs));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvs() async {
    final response = await client.get(Uri.parse(Urls.popularTvs));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvs() async {
    final response = await client.get(Uri.parse(Urls.topRatedTvs));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse(Urls.tvDetail(id)));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeasonEpisodeModel>> getTvSeasonEpisodes(
    int id,
    int seasonNumber,
  ) async {
    final response = await client.get(
      Uri.parse(Urls.tvSeasons(id, seasonNumber)),
    );

    if (response.statusCode == 200) {
      return TvSeasonEpisodeResponse.fromJson(json.decode(response.body))
          .tvEpisodes;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client.get(Uri.parse(Urls.tvRecommendations(id)));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvs(String query) async {
    final response = await client.get(Uri.parse(Urls.searchTvs(query)));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MediaImageModel> getTvImages(int id) async {
    final response = await client.get(Uri.parse(Urls.tvImages(id)));

    if (response.statusCode == 200) {
      return MediaImageModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
