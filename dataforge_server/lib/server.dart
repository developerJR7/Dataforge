import 'package:dataforge_server/src/birthday_reminder.dart';
import 'package:serverpod/serverpod.dart';

import 'package:dataforge_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

void run(List<String> args) async {
  // Inicializa o Serverpod e conecta com código gerado
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Setup default page at web root
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');

  // Serve all files in the /static directory
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server
  await pod.start();

  // Registrar futuros
  pod.registerFutureCall(
    BirthdayReminder(),
    FutureCallNames.birthdayReminder.name,
  );

  // Agendar primeira future call só para teste
  await pod.futureCallWithDelay(
    FutureCallNames.birthdayReminder.name,
    Greeting(
      message: 'Hello!',
      author: 'Serverpod Server',
      timestamp: DateTime.now(),
    ),
    Duration(seconds: 5),
  );

  print('Servidor iniciado com sucesso!');
}

/// Names of all future calls
enum FutureCallNames { birthdayReminder }
