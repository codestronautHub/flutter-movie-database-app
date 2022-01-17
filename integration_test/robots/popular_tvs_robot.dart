import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class PopularTvsRobot {
  final WidgetTester tester;
  PopularTvsRobot(this.tester);

  Future<void> scrollThePage({bool scrollUp = false}) async {
    final listViewFinder = find.byKey(Key('popularTvsListView'));

    if (scrollUp) {
      await tester.fling(listViewFinder, Offset(0, 500), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(listViewFinder, Offset(0, -500), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(Duration(seconds: 2));
  }
}