import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/save_watchlist.dart';

import '../../helpers/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late SaveWatchlist usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveWatchlist(
      tvRepository: mockTvRepository,
    );
  });

  test(
    'should save a tv to the repository',
    () async {
      // arrange
      when(mockTvRepository.saveWatchlist(testTvDetail))
          .thenAnswer((_) async => const Right('Added to watchlist'));

      // act
      final result = await usecase.executeTv(testTvDetail);

      // assert
      verify(mockTvRepository.saveWatchlist(testTvDetail));
      expect(result, equals(const Right('Added to watchlist')));
    },
  );
}
