enum HttpStatusCode(final int value) {
  ok(200),
  created(201),

  /// Note: Prefer `200 OK` with an empty JSON body (`{}`) for endpoints that may
  /// evolve to return data in the future (e.g., `/logout`).
  ///
  /// Reserve `204 No Content` for endpoints that are not expected to ever
  /// return a response body (e.g., `/ping`).
  noContent(204),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  internalServerError(500);
}
