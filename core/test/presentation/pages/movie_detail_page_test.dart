import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/provider/movie_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'watchlist button should display add icon when movie not added to watchlist',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      // act
      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(
        _makeTestableWidget(const MovieDetailPage(id: 1)),
        const Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // assert
      expect(watchlistButtonIcon, equals(findsOneWidget));
    },
  );

  testWidgets(
    'watchlist button should dispay check icon when movie is added to wathclist',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      // act
      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(
        _makeTestableWidget(const MovieDetailPage(id: 1)),
        const Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // assert
      expect(watchlistButtonIcon, equals(findsOneWidget));
    },
  );

  testWidgets(
    'watchlist button should display snackbar when added to watchlist',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to watchlist');

      // act
      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(
        _makeTestableWidget(const MovieDetailPage(id: 1)),
        const Duration(milliseconds: 500),
      );

      // assert
      expect(find.byIcon(Icons.add), equals(findsOneWidget));

      // act
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
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
      when(mockNotifier.movieState).thenReturn(RequestState.loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendations).thenReturn(<Movie>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      // act
      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(
        _makeTestableWidget(const MovieDetailPage(id: 1)),
        const Duration(milliseconds: 500),
      );

      // assert
      expect(find.byIcon(Icons.add), equals(findsOneWidget));

      // act
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(watchlistButton);
      await tester.pump();

      // assert
      expect(find.byType(AlertDialog), equals(findsOneWidget));
      expect(find.text('Failed'), equals(findsOneWidget));
    },
  );
}
