import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/utils.dart';

void main() {
  group('calculateMaxVisibleImages Tests', () {
    testWidgets('returns correct value for small screen', (WidgetTester tester) async {
      // Set small screen size
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      BuildContext? testContext;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              testContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(testContext, isNotNull);
      final result = calculateMaxVisibleImages(testContext!);
      expect(result, 3); // Expected 3 visible images for small screen
    });

    testWidgets('returns correct value for large screen', (WidgetTester tester) async {
      // Set large screen size
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      BuildContext? testContext;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              testContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(testContext, isNotNull);
      final result = calculateMaxVisibleImages(testContext!);
      expect(result, 13); // Expected 13 visible images for large screen
    });

    testWidgets('never returns less than 1', (WidgetTester tester) async {
      // Set tiny screen size
      tester.view.physicalSize = const Size(100, 100);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      BuildContext? testContext;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              testContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(testContext, isNotNull);
      final result = calculateMaxVisibleImages(testContext!);
      expect(result, 1); // Should never be less than 1
    });

    testWidgets('handles custom parameters correctly', (WidgetTester tester) async {
      // Set medium screen size
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      BuildContext? testContext;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              testContext = context;
              return Container();
            },
          ),
        ),
      );

      expect(testContext, isNotNull);
      final result = calculateMaxVisibleImages(
        testContext!,
        imageWidth: 80.0,
        imageSpacing: 10.0,
        sidePadding: 20.0,
        buttonWidth: 50.0,
        buttonCount: 2,
      );
      
      expect(result, 6); // Expected 6 visible images with custom parameters
    });
  });
}
