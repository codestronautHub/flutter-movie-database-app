import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/urls.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTvs();
  Future<List<TvModel>> getPopularTvs();
  Future<List<TvModel>> getTopRatedTvs();
  Future<List<TvModel>> searchTvs(String query);
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
  Future<List<TvModel>> searchTvs(String query) async {
    final response = await client.get(Uri.parse(Urls.searchTvs(query)));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
