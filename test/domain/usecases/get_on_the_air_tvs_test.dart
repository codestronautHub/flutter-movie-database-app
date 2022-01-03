import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirTvs usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetOnTheAirTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test(
    "should get list of tvs from the repository",
    () async {
      // arrange
      when(mockTvRepository.getOnTheAirTvs())
          .thenAnswer((_) async => Right(tTvs));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, Right(tTvs));
    },
  );
}
