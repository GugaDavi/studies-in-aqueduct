import 'package:api/api.dart';

class AppConfig extends Configuration {
  AppConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
  int port;
}
