import 'package:dataforge_server/server.dart';

void main(List<String> args) {
  try {
    run(args);
  } catch (e, stack) {
    print('ERRO AO INICIAR O SERVIDOR: $e');
    print(stack);
  }
}
