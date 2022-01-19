import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(id: 1, name: 'Genre 1');

  const tGenre = Genre(id: 1, name: 'Genre 1');

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
