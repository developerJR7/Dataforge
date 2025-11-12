import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  /// Gera hash da senha usando SHA-256 (para produção, use bcrypt)
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Verifica se a senha corresponde ao hash
  bool _verifyPassword(String password, String hash) {
    return _hashPassword(password) == hash;
  }

  /// Registra um novo usuário
  Future<User> register(
    Session session,
    String username,
    String email,
    String name,
    String password,
  ) async {
    // Verifica se o usuário já existe
    final existingUser = await User.db.findFirstRow(
      session,
      where: (t) => t.username.equals(username),
    );

    if (existingUser != null) {
      throw Exception('Username já existe');
    }

    // Hash da senha
    final passwordHash = _hashPassword(password);

    // Cria o novo usuário
    final user = User(
      username: username,
      email: email,
      name: name,
      passwordHash: passwordHash,
      createdAt: DateTime.now(),
    );

    return await User.db.insertRow(session, user);
  }

  /// Faz login e retorna o usuário (sem passwordHash)
  Future<User> login(
    Session session,
    String username,
    String password,
  ) async {
    // Busca o usuário pelo username
    final user = await User.db.findFirstRow(
      session,
      where: (t) => t.username.equals(username),
    );

    if (user == null) {
      throw Exception('Usuário ou senha inválidos');
    }

    // Verifica a senha
    final isValid = _verifyPassword(password, user.passwordHash);

    if (!isValid) {
      throw Exception('Usuário ou senha inválidos');
    }

    // Retorna o usuário (sem o passwordHash por segurança)
    return user;
  }

  /// Retorna o usuário atual (se autenticado)
  Future<User?> getCurrentUser(Session session) async {
    // Por enquanto, retorna null - pode ser implementado com autenticação do Serverpod depois
    return null;
  }
}

