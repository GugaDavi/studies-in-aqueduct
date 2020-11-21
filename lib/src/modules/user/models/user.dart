import 'package:api/api.dart';

class User extends ManagedObject<_User> implements _User {}

class _User {
  @primaryKey
  int id;

  @Column(unique: true)
  String uuid;

  @Column(nullable: false)
  String name;

  @Column(nullable: true, unique: true)
  String email;

  @Column(indexed: true)
  DateTime createdAt;

  @Column(indexed: true)
  DateTime updatedAt;
}
