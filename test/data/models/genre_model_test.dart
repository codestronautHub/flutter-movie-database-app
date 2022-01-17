import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'Genre 1');

  final tGenre = Genre(id: 1, name: 'Genre 1');

  group('to entity', () {
    test(
      'shoudl be a subclass of genre entity',
      () async {
        // assert
        final result = tGenreModel.toEntity();
        expect(result, equals(tGenre));
      },
    );
  });
}
