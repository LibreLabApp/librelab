CREATE TYPE permission AS ENUM (
  'backup:create',
  'backup:restore'
);

CREATE TABLE roles (
  id UUID PRIMARY KEY DEFAULT uuidv7(),
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE role_permissions (
  role_id UUID NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
  permission permission NOT NULL,
  PRIMARY KEY (role_id, permission)
);

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuidv7(),
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  full_name TEXT NOT NULL,
  is_superuser BOOLEAN NOT NULL DEFAULT FALSE,
  role_id UUID REFERENCES roles(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT users_superuser_role_check
    CHECK (
      (is_superuser AND role_id IS NULL)
      OR
      (NOT is_superuser AND role_id IS NOT NULL)
    )
);
