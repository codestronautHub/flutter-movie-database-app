import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TvDetailRobot {
  final WidgetTester tester;
  TvDetailRobot(this.tester);

  Future<void> clickTvToWatchlistButton() async {
    final tvToWatchlistButtonFinder = find.byKey(const Key('tvToWatchlist'));

    await tester.ensureVisible(tvToWatchlistButtonFinder);
    await tester.tap(tvToWatchlistButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> scrollThePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvDetailScrollView'));

    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
