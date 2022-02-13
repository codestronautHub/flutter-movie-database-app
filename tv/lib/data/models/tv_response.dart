import 'package:equatable/equatable.dart';

import 'tv_model.dart';

class TvResponse extends Equatable {
  final List<TvModel> tvList;

  const TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TvModel>.from((json['results'] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) =>
                element.posterPath != null && element.backdropPath != null)),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(tvList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [tvList];
}
