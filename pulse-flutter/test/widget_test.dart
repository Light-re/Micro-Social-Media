import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/main.dart';

void main() {
  testWidgets('shows pulse skeleton message', (WidgetTester tester) async {
    await tester.pumpWidget(const PulseApp());
    expect(find.text('Pulse — Flutter skeleton'), findsOneWidget);
  });
}
