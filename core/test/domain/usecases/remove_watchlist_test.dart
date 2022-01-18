import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;
  late RemoveWatchlist usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlist(
      movieRepository: mockMovieRepository,
      tvRepository: mockTvRepository,
    );
  });

  test(
    'should remove a movie from repository',
    () async {
      // arrange
      when(mockMovieRepository.removeWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Removed from watchlist'));

      // act
      final result = await usecase.executeMovie(testMovieDetail);

      // assert
      verify(mockMovieRepository.removeWatchlist(testMovieDetail));
      expect(result, equals(Right('Removed from watchlist')));
    },
  );

  test(
    'should remove a tv from repository',
    () async {
      // arrange
      when(mockTvRepository.removeWatchlist(testTvDetail))
          .thenAnswer((_) async => Right('Removed from watchlist'));

      // act
      final result = await usecase.executeTv(testTvDetail);

      // assert
      verify(mockTvRepository.removeWatchlist(testTvDetail));
      expect(result, equals(Right('Removed from watchlist')));
    },
  );
}
