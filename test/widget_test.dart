import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Registration test', (WidgetTester tester) async {
    // Построить экран регистрации.
    await tester.pumpWidget(const MaterialApp(home: Scaffold()));

    // Найти текстовые поля и кнопку.
    final usernameField = find.byType(CupertinoTextField).at(0);
    final emailField = find.byType(CupertinoTextField).at(1);
    final passwordField = find.byType(CupertinoTextField).at(2);
    final registerButton =
        find.byType(ElevatedButton); // Предположим, что это ваш GeneralButton

    // Ввод данных в текстовые поля.

    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'testpass');

    // Нажимаем на кнопку регистрации.
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Проверяем на наличие сообщения об успешной регистрации (это зависит от вашей реализации).
    expect(find.text('Registration successful!'),
        findsOneWidget); // Или другие подходящие проверки.
  });
}
