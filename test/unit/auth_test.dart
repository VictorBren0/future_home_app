import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:future_home_app/firebase_options.dart';
import 'package:future_home_app/providers/auth_provider.dart';

void main() {

  group('AuthProvider', () {
    late AuthProvider authProvider;

    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      authProvider = AuthProvider();
    });

    test('Estado inicial deve estar deslogado', () {
      expect(authProvider.token, isNull);
      expect(authProvider.message, isNull);
      expect(authProvider.isAuthenticated, isFalse);
    });

    test('Deve limpar token e mensagem ao fazer logout', () {
      // Simula um usuário logado
      authProvider.logout();

      expect(authProvider.token, isNull);
      expect(authProvider.message, isNull);
      expect(authProvider.isAuthenticated, isFalse);
    });
    test('Deve retornar mensagem de erro ao tentar registrar com email inválido', () async {
      final result = await authProvider.signUpUser('invalid-email', '123456');
      expect(result, isFalse);
      expect(authProvider.message, isNotNull);
      expect(authProvider.message, 'INVALID_EMAIL');
    });
     test('Deve retornar mensagem de erro ao tentar registrar com senha inválida', () async {
      final result = await authProvider.signUpUser('teste@teste.com', '123');
      expect(result, isFalse);
      expect(authProvider.message, isNotNull);
      expect(authProvider.message, 'WEAK_PASSWORD : Password should be at least 6 characters');
    });
  test('Deve retornar mensagem de erro ao tentar registrar com email já cadastrado', () async {
      final result = await authProvider.signUpUser('teste@gmail.com', '123456');
      expect(result, isFalse);
      expect(authProvider.message, isNotNull);
      expect(authProvider.message, 'EMAIL_EXISTS');
    });
  test('Deve retornar erro de senha inválida ao tentar logar com senha inválida', () async {
      final result = await authProvider.signInUser('teste@gmail.com', '123456789');
      expect(result, isFalse);
      expect(authProvider.message, isNotNull);
      expect(authProvider.message, 'INVALID_LOGIN_CREDENTIALS');
  });
  test('Deve retornar sucesso ao logar com credenciais válidas', () async {
      final result = await authProvider.signInUser('teste@gmail.com', '12345678');
      expect(result, isTrue);
      expect(authProvider.token, isNotNull);
      expect(authProvider.message, isNull); 
 });
 });
}
