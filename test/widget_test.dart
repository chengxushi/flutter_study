// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('my first widget test', (WidgetTester tester) async {
    // You can use keys to locate the widget you need to test
    var sliderKey = new UniqueKey();
    var value = 0.0;
    
    // Tells the tester to build a UI based on the widget tree passed to it
    await tester.pumpWidget(
      new StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return new MaterialApp(
            home: new Material(
              child: new Center(
                child: new Slider(
                  key: sliderKey,
                  value: value,
                  onChanged: (double newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
    expect(value, equals(0.0));
    
    // Taps on the widget found by key
    await tester.tap(find.byKey(sliderKey));
//    await tester.tapAt(Offset(1, 0));
    
    // Verifies that the widget updated the value correctly
    expect(value, equals(0.5));
  });
}
