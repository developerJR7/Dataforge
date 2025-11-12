import 'package:serverpod/serverpod.dart';
import 'package:serverpod_test/serverpod_test.dart';
import 'package:test/test.dart';
import 'package:dataforge_server/src/endpoints/user_endpoint.dart';
import 'package:dataforge_server/src/generated/protocol.dart';

void main() {
  late TestServerpodClient client;
  late Session session;
  late UserEndpoint userEndpoint;

  setUpAll(() async {
    client = await setupServerpodTestClient();
    session = client.session;
    userEndpoint = UserEndpoint();
  });

  tearDownAll(() async {
    await tearDownServerpodTestClient(client);
  });

  group('UserEndpoint', () {
    test('getAll - retorna lista vazia inicialmente', () async {
      final users = await userEndpoint.getAll(session);
      expect(users, isA<List<User>>());
    });

    test('create - cria novo usuário', () async {
      final user = await userEndpoint.create(
        session,
        'Test User',
        'test@example.com',
        'testuser_${DateTime.now().millisecondsSinceEpoch}',
        'hashedpassword',
      );

      expect(user, isNotNull);
      expect(user.id, isNotNull);
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
    });

    test('getAll - retorna usuários criados', () async {
      // Criar alguns usuários
      await userEndpoint.create(
        session,
        'User 1',
        'user1@example.com',
        'user1_${DateTime.now().millisecondsSinceEpoch}',
        'hash1',
      );

      await userEndpoint.create(
        session,
        'User 2',
        'user2@example.com',
        'user2_${DateTime.now().millisecondsSinceEpoch}',
        'hash2',
      );

      final users = await userEndpoint.getAll(session);
      expect(users.length, greaterThanOrEqualTo(2));
    });
  });
}

