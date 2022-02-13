import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import '../../helpers/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvDetail usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  const tId = 1;

  test(
    'should get tv detail from the repository',
    () async {
      // arrange
      when(mockTvRepository.getTvDetail(tId))
          .thenAnswer((_) async => const Right(testTvDetail));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, equals(const Right(testTvDetail)));
    },
  );
}
