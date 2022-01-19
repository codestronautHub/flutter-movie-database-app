import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetWatchlistMovies usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistMovies(mockMovieRepository);
  });

  test(
    'should get list of movie from the repository',
    () async {
      // arrange
      when(mockMovieRepository.getWatchlistMovies())
          .thenAnswer((_) async => Right(testMovieList));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, equals(Right(testMovieList)));
    },
  );
}
