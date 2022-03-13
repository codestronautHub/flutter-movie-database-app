import 'package:equatable/equatable.dart';

import 'tv_model.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvList;

  const TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TvModel>.from(
            (json['list'] as List).map((x) => TvModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'list': List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvList];
}
