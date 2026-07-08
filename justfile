# Generates Dart build_runner outputs for all packages
build-runner:
  dart run build_runner build --workspace

# Generates Dart build_runner outputs for a package
build-runner-package package="librelab_api_contract":
  cd {{package}} && dart run build_runner build

# Starts PostgreSQL database server via docker compose
db-up:
  cd librelab_server && docker compose up

# Generates database migration Dart constants from SQL files in migrations/
server-db-migrations:
  cd librelab_server && dart run scripts/database_migrations/generate.dart

# Generates Dart types from database schema definitions
server-db-schema:
  cd librelab_server && dart run scripts/database_schema/generate.dart

# Runs the application server
server-run *args:
  cd librelab_server && dart run bin/main.dart {{args}}

# Bundles server into distributable form
server-bundle:
  cd librelab_server && dart run scripts/bundle_server.dart

# Generates application API endpoint definitions (shared between API server and API client)
api-endpoint-definitions:
  cd librelab_api_contract && dart run scripts/endpoint_definition/generate.dart

# Generates localized app strings from the JSON files
app-translations:
  cd librelab_flutter && dart run slang slang.yaml

# Generates asset path bindings/paths
app-asset-paths:
  cd librelab_flutter && fluttergen

# Generates app launcher icons
app-icons:
  cd librelab_flutter && dart run flutter_launcher_icons
