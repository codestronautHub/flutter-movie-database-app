import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final int id;
  final List<String> backdropPaths;
  final List<String> logoPaths;
  final List<String> posterPaths;

  Image({
    required this.id,
    required this.backdropPaths,
    required this.logoPaths,
    required this.posterPaths,
  });

  @override
  List<Object?> get props => [id, backdropPaths, logoPaths, posterPaths];
}
