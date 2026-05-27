import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_uikit/di/dependency_injection.dart';
import 'package:flutter_uikit/myapp.dart';

void main() {
  testWidgets('App loads home page', (WidgetTester tester) async {
    Injector.configure(Flavor.mock);
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Flutter UIKit'), findsWidgets);
  });
}
