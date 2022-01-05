import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  // TODO: Add MockTvRepository
  late GetWatchListStatus usecase;
  // TODO: Add GetWatchlistTvStatus

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    // TODO: Add MockTvRepository initialization
    usecase = GetWatchListStatus(mockMovieRepository);
    // TODO: Add GetWatchlistTvStatus initialization
  });

  test(
    'should get movie watchlist status from repository',
    () async {
      // arrange
      when(mockMovieRepository.isAddedToWatchlist(1))
          .thenAnswer((_) async => true);

      // act
      final result = await usecase.execute(1);

      // assert
      expect(result, true);
    },
  );

  // TODO: Add get tv watchlist status test
}
