import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv_season_episode.dart';
import 'package:tv/domain/usecases/get_tv_season_episodes.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetTvSeasonEpisodes usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvSeasonEpisodes(mockTvRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  final tTvEpisodes = <TvSeasonEpisode>[];

  test(
    'should get list of tv season episodes from the repository',
    () async {
      // arrange
      when(mockTvRepository.getTvSeasonEpisodes(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tTvEpisodes));

      // act
      final result = await usecase.execute(tId, tSeasonNumber);

      // assert
      expect(result, equals(Right(tTvEpisodes)));
    },
  );
}
