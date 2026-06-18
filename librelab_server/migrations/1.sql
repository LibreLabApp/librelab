CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TYPE permission AS ENUM (
  'backup:create',
  'backup:restore'
);

CREATE TABLE roles (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TRIGGER roles_set_updated_at BEFORE UPDATE ON roles FOR EACH ROW EXECUTE FUNCTION set_updated_at();

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

CREATE TRIGGER users_set_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION set_updated_at();

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

CREATE TRIGGER lab_settings_set_updated_at BEFORE UPDATE ON lab_settings FOR EACH ROW EXECUTE FUNCTION set_updated_at();
