/*
** Reference: https://github.com/flutter/flutter/blob/master/packages/flutter/test/widgets/dismissible_test.dart
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

typedef DismissMethod = Future<void> Function(
    WidgetTester tester, Finder finder,
    {@required AxisDirection gestureDirection});

Future<void> flingElement(WidgetTester tester, Finder finder,
    {@required AxisDirection gestureDirection,
    double initialOffsetFactor = 0.0}) async {
  Offset delta;
  switch (gestureDirection) {
    case AxisDirection.left:
      delta = const Offset(-300.0, 0.0);
      break;
    case AxisDirection.right:
      delta = const Offset(300.0, 0.0);
      break;
    case AxisDirection.up:
      delta = const Offset(0.0, -300.0);
      break;
    case AxisDirection.down:
      delta = const Offset(0.0, 300.0);
      break;
  }
  await tester.fling(finder, delta, 1000.0,
      initialOffset: delta * initialOffsetFactor);
}

Future<void> dismissElement(WidgetTester tester, Finder finder,
    {@required AxisDirection gestureDirection}) async {
  assert(gestureDirection != null);
  Offset downLocation, upLocation;

  switch (gestureDirection) {
    case AxisDirection.left:
      downLocation = tester.getTopRight(finder) + const Offset(-0.1, 0.0);
      upLocation = tester.getTopLeft(finder);
      break;
    case AxisDirection.right:
      downLocation = tester.getTopLeft(finder) + const Offset(0.1, 0.0);
      upLocation = tester.getTopRight(finder);
      break;
    case AxisDirection.up:
      downLocation = tester.getBottomLeft(finder) + const Offset(0.0, -0.1);
      upLocation = tester.getTopLeft(finder);
      break;
    case AxisDirection.down:
      downLocation = tester.getTopLeft(finder) + const Offset(0.1, 0.0);
      upLocation = tester.getBottomLeft(finder);
      break;
  }

  final TestGesture gesture = await tester.startGesture(downLocation);
  await gesture.moveTo(upLocation);
  await gesture.up();
}

Future<void> dismissItem(WidgetTester tester, Finder finder,
    {@required AxisDirection gestureDirection,
    DismissMethod mechanism = dismissElement}) async {
  assert(gestureDirection != null);

  await mechanism(tester, finder, gestureDirection: gestureDirection);

  await tester.pump(); // start the slide
  await tester.pump(
      const Duration(seconds: 1)); // finish the slide and start shrinking...
  await tester.pump(); // first frame of shrinking animation
  await tester.pump(const Duration(
      seconds: 1)); // finish the shrinking and call the callback...
  await tester.pump(); // rebuild after the callback removes the entry
}
