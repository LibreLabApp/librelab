# Architecture

Architecture decision records (ADR).

## Server

### Explicit SqlExecutor in Repository Interfaces

Some repository interfaces accept a [SqlExecutor] to allow multiple
repository operations to participate in the same database transaction.

This exposes an infrastructure concern at the repository interface level and
therefore does not strictly follow Clean Architecture principles.

Alternative designs (such as Per-transaction repository instances, Unit of Work, or additional repository transaction abstractions) introduce their own complexity and tradeoffs.

Given that this system is intentionally SQL-based, the explicit
[SqlExecutor] dependency is accepted as a pragmatic tradeoff.

> [!NOTE]
> [SqlExecutor] is a driver-independent abstraction for executing SQL statements and is unit-testable.

[SqlExecutor]: librelab_server/lib/database/sql_executor/sql_executor.dart

## Domain Audit Snapshots (`toAuditJson()` methods)

`toAuditJson()` produces human-readable snapshots stored in `audit_logs`.

This is not an API contract and is not intended for API clients or machine parsing. The structure may change over time (fields added, removed, or modified), while existing audit records remain valid as historical data for operator inspection.

Audit values are append-only and serve as descriptive history rather than a stable schema.

This is not an infrastructure concern leaking into domain models. It is intended for lab operator visibility. Changes to response DTOs or transport layers (e.g., JSON to gRPC) do not affect it.
