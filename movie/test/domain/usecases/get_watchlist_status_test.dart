import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieRepository mockMovieRepository;
  late GetWatchlistStatus usecase;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetWatchlistStatus(
      movieRepository: mockMovieRepository,
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
}
