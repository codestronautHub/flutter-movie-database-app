import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  // TODO: Add MockTvRepository
  late SaveWatchlist usecase;
  // TODO: Add SaveWatchlistTv

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    // TODO: Add MockTvRepository initialization
    usecase = SaveWatchlist(mockMovieRepository);
    // TODO: Add SaveWatchlistTv initialization
  });

  test(
    'should save a movie to the repository',
    () async {
      // arrange
      when(mockMovieRepository.saveWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Added to watchlist'));

      // act
      final result = await usecase.execute(testMovieDetail);

      // assert
      verify(mockMovieRepository.saveWatchlist(testMovieDetail));
      expect(result, Right('Added to watchlist'));
    },
  );

  // TODO: Add save tv watchlist test
}
