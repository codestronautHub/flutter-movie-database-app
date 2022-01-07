import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late SearchTvs usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];
  final tQuery = 'Arcane';

  test(
    'should get list of tv from the repository based on query',
    () async {
      // arrange
      when(mockTvRepository.searchTvs(tQuery))
          .thenAnswer((_) async => Right(tTvs));

      // act
      final result = await usecase.execute(tQuery);

      // assert
      expect(result, equals(Right(tTvs)));
    },
  );
}
