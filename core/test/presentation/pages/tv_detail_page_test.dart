import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_season_episode.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/provider/tv_detail_notifier.dart';
import 'package:core/presentation/provider/tv_season_episodes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier, TvSeasonEpisodesNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;
  late MockTvSeasonEpisodesNotifier mockTvSeasonEpisodesNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
    mockTvSeasonEpisodesNotifier = MockTvSeasonEpisodesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: ChangeNotifierProvider<TvSeasonEpisodesNotifier>.value(
        value: mockTvSeasonEpisodesNotifier,
        child: MaterialApp(
          home: body,
        ),
      ),
    );
  }

  testWidgets(
    'watchlist button should display add icon when tv not added to watchlist',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Tv>[]);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodesState)
          .thenReturn(RequestState.loaded);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodes)
          .thenReturn(<TvSeasonEpisode>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      // act
      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(
        _makeTestableWidget(TvDetailPage(id: 1)),
        Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      // assert
      expect(watchlistButtonIcon, equals(findsOneWidget));
    },
  );

  testWidgets(
    'watchlist button should display check icon when tv is added to watchlist',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Tv>[]);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodesState)
          .thenReturn(RequestState.loaded);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodes)
          .thenReturn(<TvSeasonEpisode>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      // act
      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(
        _makeTestableWidget(TvDetailPage(id: 1)),
        Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      // assert
      expect(watchlistButtonIcon, equals(findsOneWidget));
    },
  );

  testWidgets(
    'watchlist button should display snackbar when tv is added to watchlist',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Tv>[]);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodesState)
          .thenReturn(RequestState.loaded);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodes)
          .thenReturn(<TvSeasonEpisode>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to watchlist');

      // act
      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(
        _makeTestableWidget(TvDetailPage(id: 1)),
        Duration(milliseconds: 500),
      );

      // assert
      expect(find.byIcon(Icons.add), equals(findsOneWidget));

      // act
      await tester.pumpAndSettle(Duration(milliseconds: 500));
      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(SnackBar), equals(findsOneWidget));
      expect(find.text('Added to watchlist'), equals(findsOneWidget));
    },
  );

  testWidgets(
    'watchlist button should display alert dialog when add to watchlist failed',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Tv>[]);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodesState)
          .thenReturn(RequestState.loaded);
      when(mockTvSeasonEpisodesNotifier.seasonEpisodes)
          .thenReturn(<TvSeasonEpisode>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      // act
      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(
        _makeTestableWidget(TvDetailPage(id: 1)),
        Duration(milliseconds: 500),
      );

      // assert
      expect(find.byIcon(Icons.add), equals(findsOneWidget));

      // act
      await tester.pumpAndSettle(Duration(milliseconds: 500));
      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(AlertDialog), equals(findsOneWidget));
      expect(find.text('Failed'), equals(findsOneWidget));
    },
  );
}
