import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/main.dart';

void main() {
  testWidgets('shows migrated welcome message', (tester) async {
    await tester.pumpWidget(const PulseApp());

    expect(find.text(WelcomeScreen.welcomeMessage), findsOneWidget);
    expect(find.text('http://10.0.2.2:8080'), findsOneWidget);
  });
}
