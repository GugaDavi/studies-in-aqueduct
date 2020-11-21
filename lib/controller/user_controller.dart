import 'package:api/api.dart';
import 'package:api/src/modules/user/models/user.dart';

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  @Operation.get('id')
  FutureOr<Response> getUserById(@Bind.path('id') int id) async {
    final query = Query<User>(context)..where((u) => u.id).equalTo(id);

    final user = await query.fetchOne();

    if (user == null) {
      return Response.notFound(body: {"msg": "User not found"});
    }

    return Response.ok(user);
  }

  @Operation.get()
  FutureOr<Response> getAllUsers() async {
    try {
      final query = Query<User>(context);

      final users = await query.fetch();

      return Response.ok(users);
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
