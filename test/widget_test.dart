import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_portfolio/main.dart';

void main() {
  testWidgets('PortfolioApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.byType(PortfolioApp), findsOneWidget);
  });
}
