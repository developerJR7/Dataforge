import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class TaskEndpoint extends Endpoint {
  Future<List<Task>> getAll(Session session) async {
    return await Task.db.find(session);
  }

  Future<Task> create(
    Session session,
    String title,
    String? description,
    int userId,
  ) async {
    var task = Task(
      title: title,
      description: description,
      userId: userId,
      createdAt: DateTime.now(),
    );
    return await Task.db.insertRow(session, task);
  }
}
