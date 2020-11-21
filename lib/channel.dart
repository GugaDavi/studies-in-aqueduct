import 'dart:async';
import 'package:api/app.config.dart';
import 'package:api/controller/user_controller.dart';
import 'package:aqueduct/aqueduct.dart';

class ApiChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final AppConfig appConfig = AppConfig(options.configurationFilePath);

    final DatabaseConfiguration db = appConfig.database;
    final int port = appConfig.port;

    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        db.username, db.password, db.host, db.port, db.databaseName);

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();

    options.port = port;

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/").linkFunction((request) async {
      return Response.ok({"key": "value"});
    });

    router.route('/users/[:id]').link(() => UserController(context));

    return router;
  }
}
