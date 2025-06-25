import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:future_home_app/pages/login_page.dart';
import 'package:future_home_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

Widget loginPageTest() => ChangeNotifierProvider(
  create: (context) => AuthProvider(),
  child: MaterialApp(home: const LoginPage()),
);

void main() {
  group("Testando widget LoginPage", () {
    testWidgets("Deve exibir input de email requerido", (tester) async {
      await tester.pumpWidget(loginPageTest());
      expect(find.byKey(const Key('email-input')), findsOneWidget);
      expect(find.byKey(const Key('password-input')), findsOneWidget);
      await tester.tap(find.text("Entrar"));
      await tester.pumpAndSettle();
      expect(find.text("Campo obrigatório"), findsWidgets);
    });
    testWidgets("Deve exibir input de senha requerido", (tester) async {
      await tester.pumpWidget(loginPageTest());
      expect(find.byKey(const Key('email-input')), findsOneWidget);
      expect(find.byKey(const Key('password-input')), findsOneWidget);
      await tester.tap(find.text("Entrar"));
      await tester.pumpAndSettle();
      expect(find.text("Campo obrigatório"), findsWidgets);
    });
    testWidgets(
      "Deve exibir mensagem de erro ao tentar logar com email inválido",
      (tester) async {
        await tester.pumpWidget(loginPageTest());
        await tester.enterText(
          find.byKey(const Key('email-input')),
          'invalid-email',
        );
        await tester.enterText(
          find.byKey(const Key('password-input')),
          '123456',
        );
        await tester.tap(find.text("Entrar"));
        await tester.pumpAndSettle();
        expect(find.text("Email inválido"), findsOneWidget);
      },
    );
    testWidgets(
      "Deve exibir mensagem de erro ao tentar logar com senha inválida",
      (tester) async {
        await tester.pumpWidget(loginPageTest());
        await tester.enterText(
          find.byKey(const Key('email-input')),
          'teste@teste.com',
        );
        await tester.enterText(find.byKey(const Key('password-input')), '123');
        await tester.tap(find.text("Entrar"));
        await tester.pumpAndSettle();
        expect(
          find.text("Senha deve ter pelo menos 6 caracteres"),
          findsOneWidget,
        );
      },
    );
  });
}
