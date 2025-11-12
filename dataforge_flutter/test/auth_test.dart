import 'package:flutter_test/flutter_test.dart';
import 'package:dataforge_client/dataforge_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

void main() {
  group('Authentication Tests', () {
    late Client client;

    setUp(() {
      client = Client('http://127.0.0.1:8080/')
        ..connectivityMonitor = FlutterConnectivityMonitor();
    });

    test('Client initialization', () {
      expect(client, isNotNull);
    });

    // Nota: Testes de integração reais requerem servidor rodando
    // Estes são testes de estrutura básica
  });
}

