import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_status.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetWatchlistStatus usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistStatus(
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
      final result = await usecase.executeTv(1);

      // assert
      expect(result, equals(true));
    },
  );
}
