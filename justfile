build-runner package="librelab_api_contract":
  cd {{package}} && dart run build_runner build

run-db:
  cd librelab_server && docker compose up

generate-db-migrations:
  cd librelab_server && dart run scripts/database_migrations/generate.dart

generate-db-schema:
  cd librelab_server && dart run scripts/database_schema/generate.dart

run-server:
  cd librelab_server && dart run bin/main.dart

bundle-server:
  cd librelab_server && dart run scripts/bundle_server.dart

generate-endpoints-definition:
  cd librelab_api_contract && dart run scripts/endpoint_definition/generate.dart

generate-app-translations:
  cd librelab_flutter && dart run slang slang.yaml

generate-app-asset-paths:
  cd librelab_flutter && fluttergen

generate-app-icons:
  cd librelab_flutter && dart run flutter_launcher_icons
