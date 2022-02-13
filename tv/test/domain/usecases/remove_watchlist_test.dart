import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/remove_watchlist.dart';

import '../../helpers/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late RemoveWatchlist usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveWatchlist(
      tvRepository: mockTvRepository,
    );
  });

  test(
    'should remove a tv from repository',
    () async {
      // arrange
      when(mockTvRepository.removeWatchlist(testTvDetail))
          .thenAnswer((_) async => const Right('Removed from watchlist'));

      // act
      final result = await usecase.executeTv(testTvDetail);

      // assert
      verify(mockTvRepository.removeWatchlist(testTvDetail));
      expect(result, equals(const Right('Removed from watchlist')));
    },
  );
}
