CREATE TYPE permission AS ENUM (
  'backup:create',
  'backup:restore',
  'lab_settings:update'
);

CREATE TABLE roles (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE role_permissions (
  role_id BIGINT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,
  permission permission NOT NULL,
  PRIMARY KEY (role_id, permission)
);

CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT uuidv7(),
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  token_version INTEGER NOT NULL DEFAULT 0,
  full_name TEXT NOT NULL,
  phone_number TEXT,
  is_superuser BOOLEAN NOT NULL DEFAULT FALSE,
  role_id BIGINT REFERENCES roles(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT users_email_length_check
    CHECK (length(email) BETWEEN 3 AND 254),

  CONSTRAINT users_email_format_check
    CHECK (email ~* '^[A-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[A-Z0-9-]+(\.[A-Z0-9-]+)*\.[A-Z]{2,}$'),

  CONSTRAINT users_password_hash_length_check
    CHECK (length(password_hash) <= 1024),

  CONSTRAINT users_token_version_check
    CHECK (token_version >= 0),

  CONSTRAINT users_full_name_length_check
    CHECK (length(full_name) BETWEEN 1 AND 100),

  CONSTRAINT users_phone_number_length_check
    CHECK (phone_number IS NULL OR length(phone_number) <= 20),

  CONSTRAINT users_superuser_role_check
    CHECK (
      (is_superuser AND role_id IS NULL)
      OR
      (NOT is_superuser AND role_id IS NOT NULL)
    )
);

CREATE TABLE user_refresh_tokens (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token_hash TEXT NOT NULL UNIQUE,
  device_id TEXT,
  ip_address INET,
  user_agent TEXT,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX user_refresh_tokens_expires_at_idx ON user_refresh_tokens(expires_at);
CREATE INDEX user_refresh_tokens_user_id_idx ON user_refresh_tokens(user_id);

CREATE TYPE login_result AS ENUM (
  'success',
  'invalid_credentials',
  'validation_error',
  'user_not_found',
  'locked',
  'login_disabled',
  'rate_limited'
);

CREATE TABLE login_attempts (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id UUID,
  email TEXT NOT NULL,
  result login_result NOT NULL,
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE lab_settings (
  -- Singleton
  id INTEGER PRIMARY KEY DEFAULT 1,
  lab_name TEXT,
  login_disabled BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),

  CONSTRAINT lab_settings_singleton_check
    CHECK (id = 1)
);

CREATE TYPE audit_action AS ENUM (
  'create',
  'update',
  'delete'
);

CREATE TYPE audit_entity_type AS ENUM (
  'lab_settings'
);

CREATE TABLE audit_logs (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id UUID NOT NULL,
  action audit_action NOT NULL,
  entity_type audit_entity_type NOT NULL,
  entity_id TEXT NOT NULL,
  old_value JSONB NOT NULL,
  new_value JSONB NOT NULL,
  ip_address INET,
  user_agent TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE files (
  id UUID PRIMARY KEY DEFAULT uuidv7(),
  storage_key TEXT NOT NULL UNIQUE,
  original_name TEXT NOT NULL,
  mime_type TEXT,
  size_bytes BIGINT NOT NULL,
  checksum_sha256 TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
