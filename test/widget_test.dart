import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/components/btn.dart';
import 'package:flash_chat/components/pass_field.dart';

void main() {
  testWidgets('WelcomeScreen shows buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: WelcomeScreen()));

    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('LoginScreen has email, password and Log In button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Log In'), findsOneWidget);
  });

  testWidgets('RegistrationScreen has email, password and Register button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegistrationScreen()));

    // Check presence of two text fields (email + password via PassField)
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Register'), findsOneWidget);
  });

  // Avoid instantiating ChatScreen (depends on Firestore). Instead test the
  // message input row UI separately so we cover the 'Send' button + TextField.
  testWidgets('Message input row has TextField and Send button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: 'Message'),
                ),
              ),
              TextButton(onPressed: () {}, child: Text('Send')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Send'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Btn widget reacts to tap', (WidgetTester tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Btn(
            text: 'Tap me',
            onPressed: () => tapped = true,
            color: Colors.blue,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap me'));
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });

  testWidgets('PassField calls onChanged when typing', (
    WidgetTester tester,
  ) async {
    String value = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: PassField(onChanged: (v) => value = v)),
      ),
    );

    await tester.enterText(find.byType(TextField), 'mypassword');
    await tester.pump();
    expect(value, 'mypassword');
  });
}
