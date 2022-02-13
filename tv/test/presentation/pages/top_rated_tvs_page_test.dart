import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/top_rated_tvs_page.dart';
import 'package:tv/presentation/provider/top_rated_tvs_notifier.dart';

import 'top_rated_tvs_page_test.mocks.dart';

@GenerateMocks([TopRatedTvsNotifier])
void main() {
  late MockTopRatedTvsNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display center progress bar when loading',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.loading);

      // act
      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedTvsPage()));

      // assert
      expect(centerFinder, equals(findsOneWidget));
      expect(progressBarFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'should display list view when data is loaded',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.tvs).thenReturn(<Tv>[]);

      // act
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(
        _makeTestableWidget(const TopRatedTvsPage()),
        const Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // assert
      expect(listViewFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'should display text with message when error',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      // act
      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(
        _makeTestableWidget(const TopRatedTvsPage()),
        const Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // assert
      expect(textFinder, equals(findsOneWidget));
    },
  );
}
