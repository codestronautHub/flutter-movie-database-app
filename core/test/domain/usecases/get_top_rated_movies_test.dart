import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetTopRatedMovies usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];

  test(
    'should get list of movie from repository',
    () async {
      // arrange
      when(mockMovieRepository.getTopRatedMovies())
          .thenAnswer((_) async => Right(tMovies));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, equals(Right(tMovies)));
    },
  );
}
