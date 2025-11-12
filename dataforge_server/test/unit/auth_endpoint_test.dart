import 'package:serverpod/serverpod.dart';
import 'package:serverpod_test/serverpod_test.dart';
import 'package:test/test.dart';
import 'package:dataforge_server/src/endpoints/auth_endpoint.dart';
import 'package:dataforge_server/src/generated/protocol.dart';

void main() {
  late TestServerpodClient client;
  late Session session;

  setUpAll(() async {
    client = await setupServerpodTestClient();
    session = client.session;
  });

  tearDownAll(() async {
    await tearDownServerpodTestClient(client);
  });

  group('AuthEndpoint', () {
    test('register - cria novo usuário com sucesso', () async {
      final authEndpoint = AuthEndpoint();
      
      final user = await authEndpoint.register(
        session,
        'testuser_${DateTime.now().millisecondsSinceEpoch}',
        'test@example.com',
        'Test User',
        'password123',
      );

      expect(user, isNotNull);
      expect(user.username, isNotEmpty);
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.passwordHash, isNotEmpty);
    });

    test('register - falha quando username já existe', () async {
      final authEndpoint = AuthEndpoint();
      final username = 'duplicate_${DateTime.now().millisecondsSinceEpoch}';

      await authEndpoint.register(
        session,
        username,
        'test1@example.com',
        'Test User 1',
        'password123',
      );

      expect(
        () => authEndpoint.register(
          session,
          username,
          'test2@example.com',
          'Test User 2',
          'password123',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('login - sucesso com credenciais válidas', () async {
      final authEndpoint = AuthEndpoint();
      final username = 'logintest_${DateTime.now().millisecondsSinceEpoch}';

      // Registrar primeiro
      await authEndpoint.register(
        session,
        username,
        'login@example.com',
        'Login Test',
        'password123',
      );

      // Fazer login
      final user = await authEndpoint.login(
        session,
        username,
        'password123',
      );

      expect(user, isNotNull);
      expect(user.username, username);
    });

    test('login - falha com senha incorreta', () async {
      final authEndpoint = AuthEndpoint();
      final username = 'wrongpass_${DateTime.now().millisecondsSinceEpoch}';

      await authEndpoint.register(
        session,
        username,
        'wrong@example.com',
        'Wrong Pass',
        'correctpassword',
      );

      expect(
        () => authEndpoint.login(
          session,
          username,
          'wrongpassword',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('login - falha com username inexistente', () async {
      final authEndpoint = AuthEndpoint();

      expect(
        () => authEndpoint.login(
          session,
          'nonexistent_user',
          'anypassword',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}

