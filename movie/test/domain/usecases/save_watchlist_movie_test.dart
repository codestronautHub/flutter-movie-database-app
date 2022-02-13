import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/save_watchlist_movie.dart';

import '../../helpers/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late SaveWatchlistMovie usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SaveWatchlistMovie(
      movieRepository: mockMovieRepository,
    );
  });

  test(
    'should save a movie to the repository',
    () async {
      // arrange
      when(mockMovieRepository.saveWatchlist(testMovieDetail))
          .thenAnswer((_) async => const Right('Added to watchlist'));

      // act
      final result = await usecase.execute(testMovieDetail);

      // assert
      verify(mockMovieRepository.saveWatchlist(testMovieDetail));
      expect(result, equals(const Right('Added to watchlist')));
    },
  );
}
