# Aprendendo sobre Aqueduct

## Start da aplicação:

A aplicação tem inicio em uma instancia que extende a clase `ApplicationChannel`

## Routing:

Existem 3 tipos de roteamento:

### `"/users/[:id]"`

- Usado para rotas de tipo: `/users/1`, `users/2` e etc.

### `"/file/\*"

- Usado para rotas que começam com: `/file/`

### `"/users"`

- Usado para uma rota especifica: `/users`

```dart
@override
Controller get entryPoint {
  final router = Router();

  // Handles /users, /users/1, /users/2, etc.
  router
    .route("/projects/[:id]")
    .link(() => ProjectController());

  // Handles any route that starts with /file/
  router
    .route("/file/*")
    .link(() => FileController());

  // Handles the specific route /health
  router
    .route("/health")
    .linkFunction((req) async => Response.ok(null));

  return router;
}
```

## Controllers:

Tem função de middlewares, quando retorna uma resposta do tipo `Response` será mostrado para o cliente, se for do tipo `Request` a requisição terá contiunidade.

Exemplo:

```dart
class SecretKeyAuthorizer extends Controller {
  @override
  Future<RequestOrResponse> handle(Request request) async {
    if (request.raw.headers.value("x-secret-key") == "secret!") {
      return request;
    }

    return Response.badRequest();
  }
}
```

## ResourceControllers:

Endpoints da aplicação, onde será armazenada a tratativa e o retorno para as chamadas HTTP.

```dart
class ProjectController extends ResourceController {
  @Operation.get('id')
  Future<Response> getProjectById(@Bind.path("id") int id) async {
    // GET /projects/:id
    return Response.ok(...);
  }

  @Operation.post()
  Future<Response> createProject(@Bind.body() Project project) async {
    // POST /project
    final inserted = await insertProject(project);
    return Response.ok(inserted);
  }

  @Operation.get()
  Future<Response> getAllProjects(
    @Bind.header("x-client-id") String clientId,
    {@Bind.query("limit") int limit: 10}) async {
    // GET /projects
    return Response.ok(...);
  }
}
```
