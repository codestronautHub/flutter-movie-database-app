import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/usecases/get_tv_seasons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvSeasons usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeasons(mockTvRepository);
  });

  final tId = 1;
  final tSeasonNumber = 1;
  final tTvEpisodes = <TvEpisode>[];

  test(
    'should get list of tv episodes from the repository',
    () async {
      // arrange
      when(mockTvRepository.getTvSeasons(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tTvEpisodes));

      // act
      final result = await usecase.execute(tId, tSeasonNumber);

      // assert
      expect(result, equals(Right(tTvEpisodes)));
    },
  );
}
