

import 'package:flutter_test/flutter_test.dart';
import 'package:todo/todo_app.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TodoApp());

  
    expect(find.byType(TodoApp), findsOneWidget);
  });
}