import 'package:flutter_test/flutter_test.dart';
import 'package:midsem_exams/main.dart';

void main() {
  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Note: async main might need pump() or similar if Firebase initialization is awaited.
    // However, in test environment, we often mock or skip that.
    await tester.pumpWidget(const MyApp());

    // Verify that we start on the Login screen.
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
