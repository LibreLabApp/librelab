import 'package:librelab_server/auth/authorization_service.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/user/response_mappers.dart';
import 'package:shelf/shelf.dart';

class UserController({required final AuthorizationService _authorization}) {
  Future<Response> getCurrentUser(Request request) =>
      _authorization.withFullUser(request, (user) async {
        return user.toResponse().toJson().httpResponse(.ok);
      });
}
