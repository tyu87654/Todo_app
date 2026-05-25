import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/main.dart';

void main() {
  testWidgets('Login test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // ДАЄМО ЧАС UI ПОБУДУВАТИСЬ
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'test@test.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');

    // КРАЩЕ ШУКАТИ КНОПКУ ТАК:
    final loginButton = find.byType(ElevatedButton);

    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Успішний вхід!'), findsOneWidget);
  });
}