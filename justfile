run-db:
  cd librelab_server && docker compose up

run-server:
  cd librelab_server && dart run bin/main.dart

build-runner package="librelab_api_contract":
  cd {{package}} && dart run build_runner build

generate-endpoints-definition:
  cd librelab_api_contract && dart run scripts/endpoint_definition/generate.dart

generate-dart-db-migrations:
  cd librelab_server && dart run scripts/database_migrations/generate.dart

generate-dart-db-schema:
  cd librelab_server && dart run scripts/database_schema/generate.dart

bundle-server:
  cd librelab_server && dart run scripts/bundle_server.dart
