import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuvari_app/utils.dart';

void main() {
  group('calculateMaxVisibleImages Tests', () {
    testWidgets('returns correct value for small screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Set small screen size
              tester.binding.window.physicalSizeTestValue = const Size(320, 568);
              tester.binding.window.devicePixelRatioTestValue = 1.0;

              final result = calculateMaxVisibleImages(context);
              expect(result, 2); // Expected 2 visible images for small screen

              // Reset the test values
              tester.binding.window.clearPhysicalSizeTestValue();
              tester.binding.window.clearDevicePixelRatioTestValue();
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('returns correct value for large screen', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Set large screen size
              tester.binding.window.physicalSizeTestValue = const Size(1024, 768);
              tester.binding.window.devicePixelRatioTestValue = 1.0;

              final result = calculateMaxVisibleImages(context);
              expect(result, 12); // Expected 12 visible images for large screen

              // Reset the test values
              tester.binding.window.clearPhysicalSizeTestValue();
              tester.binding.window.clearDevicePixelRatioTestValue();
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('never returns less than 1', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Set tiny screen size
              tester.binding.window.physicalSizeTestValue = const Size(100, 100);
              tester.binding.window.devicePixelRatioTestValue = 1.0;

              final result = calculateMaxVisibleImages(context);
              expect(result, 1); // Should never be less than 1

              // Reset the test values
              tester.binding.window.clearPhysicalSizeTestValue();
              tester.binding.window.clearDevicePixelRatioTestValue();
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('handles custom parameters correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Set medium screen size
              tester.binding.window.physicalSizeTestValue = const Size(600, 800);
              tester.binding.window.devicePixelRatioTestValue = 1.0;

              final result = calculateMaxVisibleImages(
                context,
                imageWidth: 80.0,
                imageSpacing: 10.0,
                sidePadding: 20.0,
                buttonWidth: 50.0,
                buttonCount: 2,
              );
              
              expect(result, 4); // Expected 4 visible images with custom parameters

              // Reset the test values
              tester.binding.window.clearPhysicalSizeTestValue();
              tester.binding.window.clearDevicePixelRatioTestValue();
              return Container();
            },
          ),
        ),
      );
    });
  });
}
