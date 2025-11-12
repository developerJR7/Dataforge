import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class UserEndpoint extends Endpoint {
  Future<List<User>> getAll(Session session) async {
    return await User.db.find(session);
  }

  Future<User> create(
    Session session,
    String name,
    String email,
    String username,
    String passwordHash,
  ) async {
    var user = User(
      name: name,
      email: email,
      username: username,
      passwordHash: passwordHash,
      createdAt: DateTime.now(),
    );
    return await User.db.insertRow(session, user);
  }
}
