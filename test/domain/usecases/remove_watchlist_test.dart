import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  // TODO: Add MockTvRepository
  late RemoveWatchlist usecase;
  // TODO: Add RemoveWatchlistTv

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    // TODO: Add MockTvRepository initialization
    usecase = RemoveWatchlist(mockMovieRepository);
    // TODO: Add RemoveWatchlistTv initialization
  });

  test(
    'should remove a movie from repository',
    () async {
      // arrange
      when(mockMovieRepository.removeWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Removed from watchlist'));

      // act
      final result = await usecase.execute(testMovieDetail);

      // assert
      verify(mockMovieRepository.removeWatchlist(testMovieDetail));
      expect(result, Right('Removed from watchlist'));
    },
  );

  // TODO: Add remove tv watchlist test
}
