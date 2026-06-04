# Database migrations

This directory contains the database migrations.

> [!WARNING]
> Older migration files should never be removed
or modified after release.

Create a new migration file with the next sequential name (e.g., if latest is `3.sql`, create `4.sql`), then run:

```dart
dart scripts/database_migrations/generate.dart
```
