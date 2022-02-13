import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvWatchlistStatus usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvWatchlistStatus(
      tvRepository: mockTvRepository,
    );
  });

  test(
    'should get tv watchlist status from repository',
    () async {
      // arrange
      when(mockTvRepository.isAddedToWatchlist(1))
          .thenAnswer((_) async => true);

      // act
      final result = await usecase.execute(1);

      // assert
      expect(result, equals(true));
    },
  );
}
