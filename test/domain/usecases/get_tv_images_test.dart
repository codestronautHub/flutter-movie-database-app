import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_images.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvImages usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvImages(mockTvRepository);
  });

  final tId = 1;

  test(
    'should get tv images from the repository',
    () async {
      // arrange
      when(mockTvRepository.getTvImages(tId))
          .thenAnswer((_) async => Right(testImages));

      // act
      final result = await usecase.execute(tId);

      // assert
      expect(result, equals(Right(testImages)));
    },
  );
}
