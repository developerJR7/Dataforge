/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:dataforge_client/src/protocol/user.dart' as _i3;
import 'package:dataforge_client/src/protocol/task.dart' as _i4;
import 'package:dataforge_client/src/protocol/greeting.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Registra um novo usuário
  _i2.Future<_i3.User> register(
    String username,
    String email,
    String name,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.User>(
        'auth',
        'register',
        {
          'username': username,
          'email': email,
          'name': name,
          'password': password,
        },
      );

  /// Faz login e retorna o usuário (sem passwordHash)
  _i2.Future<_i3.User> login(
    String username,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.User>(
        'auth',
        'login',
        {
          'username': username,
          'password': password,
        },
      );

  /// Retorna o usuário atual (se autenticado)
  _i2.Future<_i3.User?> getCurrentUser() =>
      caller.callServerEndpoint<_i3.User?>(
        'auth',
        'getCurrentUser',
        {},
      );
}

/// {@category Endpoint}
class EndpointTask extends _i1.EndpointRef {
  EndpointTask(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  _i2.Future<List<_i4.Task>> getAll() =>
      caller.callServerEndpoint<List<_i4.Task>>(
        'task',
        'getAll',
        {},
      );

  _i2.Future<_i4.Task> create(
    String title,
    String? description,
    int userId,
  ) =>
      caller.callServerEndpoint<_i4.Task>(
        'task',
        'create',
        {
          'title': title,
          'description': description,
          'userId': userId,
        },
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<List<_i3.User>> getAll() =>
      caller.callServerEndpoint<List<_i3.User>>(
        'user',
        'getAll',
        {},
      );

  _i2.Future<_i3.User> create(
    String name,
    String email,
    String username,
    String passwordHash,
  ) =>
      caller.callServerEndpoint<_i3.User>(
        'user',
        'create',
        {
          'name': name,
          'email': email,
          'username': username,
          'passwordHash': passwordHash,
        },
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i5.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i5.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i6.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    task = EndpointTask(this);
    user = EndpointUser(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointAuth auth;

  late final EndpointTask task;

  late final EndpointUser user;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'task': task,
        'user': user,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
