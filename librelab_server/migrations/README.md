# Database migrations

This directory contains the database migrations.

> [!WARNING]
> Older migration files should never be removed
or modified after release.

## Create a new migration

Create a new migration file with the next sequential name (e.g., if the latest is `3.sql`, create `4.sql`).

<details><summary>Example migration script</summary>

```sql
CREATE TABLE
    users (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        email TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL
    );
```

</details>

Then run:

```shell
dart scripts/database_migrations/generate.dart
```

This script embeds the SQL migration scripts directly in Dart code,
to avoid runtime IO operations.

### Generate type-safe code

After creating the migration file and running the script,
we can now execute SQL code directly in Dart referencing the new tables/columns.

However, instead of hardcoding table and column names directly,
we generate code to reference tables and columns in the database
in a type-safe way, which is less error prone.

1. Run the Dart script [above](#create-a-new-migration).
    This ensures the embedded migration script changes are also reflected in the Dart code.

2. Run the server once to apply the migrations (important)

    The follow-up script will run SQL commands in a real database 
    to read schema metadata (table/column names, types, nullability).

    The database must be running as well (via Docker or system installation), and it should be clean (without non-app tables).

    Run the server once to apply all migrations to the database:

    ```shell
    docker compose up # Starts PostgreSQL database server
    dart bin/main.dart
    ```

    Then once they are applied successfully, you can shutdown the server.

3. Run the following script:

    ```shell
    # Review the config in the file before running
    dart scripts/database_schema/generate.dart
    ```

    Then use the generated code.

    <details><summary>Example</summary>

    ```dart
    // Example (UsersTable and UsersRow are generated from users table)

    final result = await connection.execute(
    'SELECT * FROM ${UsersTable.tableName}',
    );
    final parsed = result.map((e) => UsersRow.fromMap(e.toColumnMap()));

    print(parsed.firstOrNull?.email);
    ```

    </details>
