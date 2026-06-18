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

2. Run the database server to apply the migrations in the next step.

    The follow-up script will run SQL commands in a real database 
    to read schema metadata (table/column names, types, nullability).

    The database must be running as well (via Docker or system installation), and it should be clean (without non-app tables).

    Run the database server to apply all migrations to the database in the **next step**:

    ```shell
    docker compose down -v # Optional to stop and start fresh
    docker compose up # Starts PostgreSQL database server
    ```

3. Generate the Dart code:

    Run the following script:

    ```shell
    # Review the config in the file before running
    dart scripts/database_schema/generate.dart
    ```

    Once the task finishes successfully, you can shutdown the database server if not needed:

    ```shell
    docker compose down # Stops PostgreSQL database server
    ```

    Now you can import and use the generated Dart code (see the example bellow).

    <details><summary>Example usage</summary>

    ```dart
    // Example (UsersTable and UsersRow are generated from users table)

    final result = await connection.execute(
    'SELECT * FROM ${UsersTable.tableName}',
    );
    final rows = result.map((e) => UsersRow.fromMap(e.toColumnMap()));

    print(rows.firstOrNull?.email);
    ```

    </details>
