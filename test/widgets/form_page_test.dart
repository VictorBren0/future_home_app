import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:future_home_app/pages/form_page.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:provider/provider.dart';

Widget formPageTest() => ChangeNotifierProvider(
      create: (_) => ResidenceProvider(),
      child: const MaterialApp(
        home: FormPage(),
      ),
    );

void main() {
  group("Testando widget FormPage", () {
    testWidgets("Deve exibir campos obrigatórios e validar ao tentar salvar sem preencher", (tester) async {
      await tester.pumpWidget(formPageTest());
      expect(find.byKey(const Key('address-input')), findsOneWidget);
      expect(find.byKey(const Key('neighborhood-input')), findsOneWidget);
      expect(find.byKey(const Key('nr-rooms-select')), findsOneWidget);
      expect(find.byKey(const Key('nr-bathrooms-select')), findsOneWidget);
      expect(find.byKey(const Key('nr-garages-select')), findsOneWidget);
      expect(find.byKey(const Key('fl-pool-select')), findsOneWidget);
      final salvarButton = find.widgetWithText(ElevatedButton, 'Salvar');
      await tester.ensureVisible(salvarButton);
      await tester.tap(salvarButton);
      await tester.pumpAndSettle();

      expect(find.text('Campo obrigatório'), findsWidgets);
    });
  });
}
