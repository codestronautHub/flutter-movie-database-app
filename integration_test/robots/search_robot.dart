import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchRobot {
  final WidgetTester tester;
  SearchRobot(this.tester);

  Future<void> openFilterDialog() async {
    final filterButtonFinder = find.byKey(Key('openFilterDialog'));

    await tester.ensureVisible(filterButtonFinder);
    await tester.tap(filterButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> selectFilterMovie() async {
    final filterMovieRadioButtonFinder = find.byKey(Key('filterByMovie'));

    await tester.ensureVisible(filterMovieRadioButtonFinder);
    await tester.tap(filterMovieRadioButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> selectFilterTv() async {
    final filterTvRadioButtonFinder = find.byKey(Key('filterByTv'));

    await tester.ensureVisible(filterTvRadioButtonFinder);
    await tester.tap(filterTvRadioButtonFinder);

    await tester.pumpAndSettle();
  }

  Future<void> enterSearchQuery(String query) async {
    final textFieldFinder = find.byKey(Key('enterSearchQuery'));

    await tester.ensureVisible(textFieldFinder);
    await tester.enterText(textFieldFinder, query);
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(Duration(seconds: 2));
  }
}
