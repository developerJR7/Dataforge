import 'package:dataforge_client/dataforge_client.dart';

Future<void> main() async {
  final client = Client(
    'http://localhost:8080/',
    connectionTimeout: const Duration(seconds: 5),
  );

  final suffix = DateTime.now().millisecondsSinceEpoch;

  final user = await client.auth.register(
    'verificacao_$suffix',
    'verificacao_$suffix@example.com',
    'Usuário Verificação',
    'senhaSegura123',
  );

  print('Usuário cadastrado: id=${user.id}, username=${user.username}');
}
