import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;
  late SaveWatchlist usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlist(
      movieRepository: mockMovieRepository,
      tvRepository: mockTvRepository,
    );
  });

  test(
    'should save a movie to the repository',
    () async {
      // arrange
      when(mockMovieRepository.saveWatchlist(testMovieDetail))
          .thenAnswer((_) async => Right('Added to watchlist'));

      // act
      final result = await usecase.executeMovie(testMovieDetail);

      // assert
      verify(mockMovieRepository.saveWatchlist(testMovieDetail));
      expect(result, Right('Added to watchlist'));
    },
  );

  test(
    'should save a tv to the repository',
    () async {
      // arrange
      when(mockTvRepository.saveWatchlist(testTvDetail))
          .thenAnswer((_) async => Right('Added to watchlist'));

      // act
      final result = await usecase.executeTv(testTvDetail);

      // assert
      verify(mockTvRepository.saveWatchlist(testTvDetail));
      expect(result, Right('Added to watchlist'));
    },
  );
}
