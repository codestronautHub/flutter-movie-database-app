import 'package:ditonton/domain/entities/image.dart';
import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final int id;
  final List<String> backdropPaths;
  final List<String> logoPaths;
  final List<String> posterPaths;

  ImageModel({
    required this.id,
    required this.backdropPaths,
    required this.logoPaths,
    required this.posterPaths,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json['id'],
        backdropPaths: List<String>.from(
          json['backdrops'].map((x) => x['file_path']),
        ),
        logoPaths: List<String>.from(
          json['logos'].map((x) => x['file_path']),
        ),
        posterPaths: List<String>.from(
          json['posters'].map((x) => x['file_path']),
        ),
      );

  Image toEntity() => Image(
        id: this.id,
        backdropPaths: this.backdropPaths,
        logoPaths: this.logoPaths,
        posterPaths: this.posterPaths,
      );

  @override
  List<Object?> get props => [
        id,
        backdropPaths,
        logoPaths,
        posterPaths,
      ];
}
