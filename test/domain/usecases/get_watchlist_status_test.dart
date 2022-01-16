import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;
  late GetWatchlistStatus usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistStatus(
      movieRepository: mockMovieRepository,
      tvRepository: mockTvRepository,
    );
  });

  test(
    'should get movie watchlist status from repository',
    () async {
      // arrange
      when(mockMovieRepository.isAddedToWatchlist(1))
          .thenAnswer((_) async => true);

      // act
      final result = await usecase.executeMovie(1);

      // assert
      expect(result, equals(true));
    },
  );

  test(
    'should get tv watchlist status from repository',
    () async {
      // arrange
      when(mockTvRepository.isAddedToWatchlist(1))
          .thenAnswer((_) async => true);

      // act
      final result = await usecase.executeTv(1);

      // assert
      expect(result, equals(true));
    },
  );
}
