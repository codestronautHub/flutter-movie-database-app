import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late SearchMovies usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  const tQuery = 'Spiderman';

  test(
    'should get list of movie from the repository based on query',
    () async {
      // arrange
      when(mockMovieRepository.searchMovies(tQuery))
          .thenAnswer((_) async => Right(tMovies));

      // act
      final result = await usecase.execute(tQuery);

      // assert
      expect(result, equals(Right(tMovies)));
    },
  );
}
