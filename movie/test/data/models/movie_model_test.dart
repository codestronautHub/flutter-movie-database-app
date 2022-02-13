import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_model.dart';
import 'package:movie/domain/entities/movie.dart';

void main() {
  const tMovieModel = MovieModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMovie = Movie(
    backdropPath: '/path.jpg',
    genreIds: const [1, 2, 3, 4],
    id: 1,
    overview: 'Overview',
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
  );

  group('to entity', () {
    test(
      'should be a subclass of movie entity',
      () async {
        // act
        final result = tMovieModel.toEntity();

        // assert
        expect(result, equals(tMovie));
      },
    );
  });
}
