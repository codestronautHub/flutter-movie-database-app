import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tvs.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetPopularTvs usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test(
    'should get list of tv from the repository',
    () async {
      // arrange
      when(mockTvRepository.getPopularTvs())
          .thenAnswer((_) async => Right(tTvs));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, equals(Right(tTvs)));
    },
  );
}
