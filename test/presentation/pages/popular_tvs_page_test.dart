import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/provider/popular_tvs_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'popular_tvs_page_test.mocks.dart';

@GenerateMocks([PopularTvsNotifier])
void main() {
  late MockPopularTvsNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularTvsNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTvsNotifier>.value(
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
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      // act
      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

      // assert
      expect(centerFinder, equals(findsOneWidget));
      expect(progressBarFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'should display list view when data is loaded',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvs).thenReturn(<Tv>[]);

      // act
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(
        _makeTestableWidget(PopularTvsPage()),
        Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      // assert
      expect(listViewFinder, equals(findsOneWidget));
    },
  );

  testWidgets(
    'should display text with message when error',
    (WidgetTester tester) async {
      // arrange
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      // act
      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(
        _makeTestableWidget(PopularTvsPage()),
        Duration(milliseconds: 500),
      );
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      // assert
      expect(textFinder, equals(findsOneWidget));
    },
  );
}
