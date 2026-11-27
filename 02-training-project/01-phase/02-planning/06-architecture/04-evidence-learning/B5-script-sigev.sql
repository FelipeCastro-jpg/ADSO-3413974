-- SIGEV · script de creación · PostgreSQL 16 · esquema sigev
-- Estándar: tablas en plural snake_case; PK 'id' (UUID) salvo tablas débiles/intermedias; FK '<entidad>_id'; restricciones <tabla>_<campo>_<pk|fk|uq|ck>
DROP SCHEMA IF EXISTS sigev CASCADE;
CREATE SCHEMA sigev;
SET search_path TO sigev;

-- Personas inscritas (con o sin cuenta); dato personal
CREATE TABLE personas (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tipo_doc           CHAR(2) NOT NULL CONSTRAINT personas_tipo_doc_ck CHECK (tipo_doc IN ('CC','CE','TI','PA')),
  numero_doc         VARCHAR(20) NOT NULL,
  nombre_completo    VARCHAR(150) NOT NULL,
  correo_contacto    VARCHAR(150) NOT NULL CONSTRAINT personas_correo_ck CHECK (position('@' in correo_contacto) > 1),
  creado_en          TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT personas_doc_uq UNIQUE (tipo_doc, numero_doc)
);

-- Teléfonos de una persona (atributo multivaluado)
CREATE TABLE telefonos_persona (
  persona_id         UUID NOT NULL,
  numero             VARCHAR(15) NOT NULL CONSTRAINT telefonos_numero_ck CHECK (numero ~ '^[0-9]{7,15}$'),
  CONSTRAINT telefonos_persona_pk PRIMARY KEY (persona_id, numero),
  CONSTRAINT telefonos_persona_fk FOREIGN KEY (persona_id) REFERENCES personas (id) ON DELETE CASCADE
);

-- Cuentas de acceso al sistema
CREATE TABLE cuentas (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  persona_id         UUID NOT NULL CONSTRAINT cuentas_persona_uq UNIQUE,
  correo_acceso      VARCHAR(150) NOT NULL CONSTRAINT cuentas_correo_uq UNIQUE,
  hash_clave         VARCHAR(100) NOT NULL,
  intentos_fallidos  SMALLINT NOT NULL DEFAULT 0 CONSTRAINT cuentas_intentos_ck CHECK (intentos_fallidos BETWEEN 0 AND 5),
  estado             VARCHAR(10) NOT NULL DEFAULT 'activa' CONSTRAINT cuentas_estado_ck CHECK (estado IN ('activa','bloqueada','cerrada')),
  CONSTRAINT cuentas_persona_fk FOREIGN KEY (persona_id) REFERENCES personas (id) ON DELETE RESTRICT
);

-- Roles de negocio
CREATE TABLE roles (
  codigo             VARCHAR(15) PRIMARY KEY CONSTRAINT roles_codigo_ck CHECK (codigo IN ('superadmin','organizador','validador','asistente')),
  nombre             VARCHAR(40) NOT NULL,
  permisos           TEXT[] NOT NULL DEFAULT '{}'
);

-- Asignación de roles a cuentas (resuelve N:M cuentas–roles)
CREATE TABLE asignaciones (
  cuenta_id          UUID NOT NULL,
  rol_codigo         VARCHAR(15) NOT NULL,
  fecha_asignacion   TIMESTAMPTZ NOT NULL DEFAULT now(),
  asignado_por       UUID,
  vigente            BOOLEAN NOT NULL DEFAULT true,
  CONSTRAINT asignaciones_pk PRIMARY KEY (cuenta_id, rol_codigo),
  CONSTRAINT asignaciones_cuenta_fk FOREIGN KEY (cuenta_id) REFERENCES cuentas (id) ON DELETE CASCADE,
  CONSTRAINT asignaciones_rol_fk FOREIGN KEY (rol_codigo) REFERENCES roles (codigo) ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT asignaciones_por_fk FOREIGN KEY (asignado_por) REFERENCES cuentas (id) ON DELETE SET NULL
);

-- Autorizaciones de tratamiento de datos (Ley 1581)
CREATE TABLE consentimientos (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  persona_id         UUID NOT NULL,
  version_politica   VARCHAR(10) NOT NULL,
  otorgado_en        TIMESTAMPTZ NOT NULL DEFAULT now(),
  revocado_en        TIMESTAMPTZ,
  CONSTRAINT consentimientos_persona_fk FOREIGN KEY (persona_id) REFERENCES personas (id) ON DELETE RESTRICT,
  CONSTRAINT consentimientos_fechas_ck CHECK (revocado_en IS NULL OR revocado_en >= otorgado_en)
);

-- Lugares de los eventos
CREATE TABLE recintos (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre             VARCHAR(100) NOT NULL CONSTRAINT recintos_nombre_uq UNIQUE,
  direccion          VARCHAR(150) NOT NULL,
  capacidad_fisica   INTEGER NOT NULL CONSTRAINT recintos_capacidad_ck CHECK (capacidad_fisica > 0)
);

-- Puertas de un recinto (entidad débil)
CREATE TABLE puertas (
  recinto_id         UUID NOT NULL,
  nro_puerta         SMALLINT NOT NULL CONSTRAINT puertas_nro_ck CHECK (nro_puerta > 0),
  nombre             VARCHAR(40) NOT NULL,
  habilitada         BOOLEAN NOT NULL DEFAULT true,
  CONSTRAINT puertas_pk PRIMARY KEY (recinto_id, nro_puerta),
  CONSTRAINT puertas_recinto_fk FOREIGN KEY (recinto_id) REFERENCES recintos (id) ON DELETE CASCADE
);

-- Eventos programados
CREATE TABLE eventos (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  recinto_id         UUID NOT NULL,
  organizador_id     UUID NOT NULL,
  titulo             VARCHAR(150) NOT NULL,
  inicia_en          TIMESTAMPTZ NOT NULL,
  termina_en         TIMESTAMPTZ NOT NULL,
  aforo_maximo       INTEGER NOT NULL CONSTRAINT eventos_aforo_ck CHECK (aforo_maximo > 0),
  estado             VARCHAR(12) NOT NULL DEFAULT 'programado' CONSTRAINT eventos_estado_ck CHECK (estado IN ('programado','en_curso','cerrado','cancelado')),
  CONSTRAINT eventos_recinto_fk FOREIGN KEY (recinto_id) REFERENCES recintos (id) ON DELETE RESTRICT,
  CONSTRAINT eventos_organizador_fk FOREIGN KEY (organizador_id) REFERENCES cuentas (id) ON DELETE RESTRICT,
  CONSTRAINT eventos_fechas_ck CHECK (termina_en > inicia_en)
);

-- Tipos de entrada de un evento
CREATE TABLE tipos_entrada (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  evento_id          UUID NOT NULL,
  nombre             VARCHAR(40) NOT NULL,
  cupo               INTEGER NOT NULL CONSTRAINT tipos_cupo_ck CHECK (cupo > 0),
  precio             NUMERIC(10,2) NOT NULL CONSTRAINT tipos_precio_ck CHECK (precio >= 0),
  CONSTRAINT tipos_entrada_evento_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE,
  CONSTRAINT tipos_entrada_nombre_uq UNIQUE (evento_id, nombre)
);

-- Archivos de carga masiva de asistentes (RF11)
CREATE TABLE lotes_carga (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  evento_id          UUID NOT NULL,
  cargado_por        UUID NOT NULL,
  nombre_archivo     VARCHAR(120) NOT NULL,
  filas_leidas       INTEGER NOT NULL,
  filas_rechazadas   INTEGER NOT NULL DEFAULT 0,
  cargado_en         TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT lotes_evento_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE,
  CONSTRAINT lotes_cuenta_fk FOREIGN KEY (cargado_por) REFERENCES cuentas (id) ON DELETE RESTRICT,
  CONSTRAINT lotes_filas_ck CHECK (filas_rechazadas >= 0 AND filas_leidas >= filas_rechazadas)
);

-- Entradas emitidas
CREATE TABLE entradas (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo             VARCHAR(32) NOT NULL CONSTRAINT entradas_codigo_uq UNIQUE,
  tipo_entrada_id    UUID NOT NULL,
  titular_id         UUID NOT NULL,
  lote_id            UUID,
  estado             VARCHAR(10) NOT NULL DEFAULT 'vigente' CONSTRAINT entradas_estado_ck CHECK (estado IN ('vigente','usada','anulada')),
  emitida_en         TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT entradas_tipo_fk FOREIGN KEY (tipo_entrada_id) REFERENCES tipos_entrada (id) ON DELETE RESTRICT,
  CONSTRAINT entradas_titular_fk FOREIGN KEY (titular_id) REFERENCES personas (id) ON DELETE RESTRICT,
  CONSTRAINT entradas_lote_fk FOREIGN KEY (lote_id) REFERENCES lotes_carga (id) ON DELETE SET NULL,
  CONSTRAINT entradas_titular_tipo_uq UNIQUE (titular_id, tipo_entrada_id)
);

-- Cada paso por una puerta (entrada o salida)
CREATE TABLE registros_ingreso (
  id                 BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  entrada_id         UUID NOT NULL,
  recinto_id         UUID NOT NULL,
  nro_puerta         SMALLINT NOT NULL,
  validador_id       UUID NOT NULL,
  sentido            CHAR(1) NOT NULL CONSTRAINT registros_sentido_ck CHECK (sentido IN ('E','S')),
  resultado          VARCHAR(9) NOT NULL CONSTRAINT registros_resultado_ck CHECK (resultado IN ('aceptado','rechazado')),
  motivo             VARCHAR(60),
  ocurrido_en        TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT registros_entrada_fk FOREIGN KEY (entrada_id) REFERENCES entradas (id) ON DELETE RESTRICT,
  CONSTRAINT registros_puerta_fk FOREIGN KEY (recinto_id, nro_puerta) REFERENCES puertas (recinto_id, nro_puerta) ON DELETE RESTRICT,
  CONSTRAINT registros_validador_fk FOREIGN KEY (validador_id) REFERENCES cuentas (id) ON DELETE RESTRICT,
  CONSTRAINT registros_motivo_ck CHECK (resultado = 'aceptado' OR motivo IS NOT NULL)
);

-- Auditoría de solo inserción (RF12)
CREATE TABLE bitacora (
  id                 BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cuenta_id          UUID,
  comando            VARCHAR(40) NOT NULL,
  detalle            JSONB NOT NULL,
  huella             CHAR(64) NOT NULL CONSTRAINT bitacora_huella_uq UNIQUE,
  ocurrido_en        TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT bitacora_cuenta_fk FOREIGN KEY (cuenta_id) REFERENCES cuentas (id) ON DELETE SET NULL
);

CREATE INDEX registros_entrada_ix ON registros_ingreso (entrada_id);
CREATE INDEX registros_fecha_ix ON registros_ingreso (ocurrido_en);
CREATE INDEX entradas_titular_ix ON entradas (titular_id);

-- Integridad: bitácora de solo inserción
CREATE FUNCTION bitacora_solo_insercion() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'bitacora: operación % no permitida', TG_OP; END $$;
CREATE TRIGGER bitacora_sin_cambios BEFORE UPDATE OR DELETE ON bitacora FOR EACH ROW EXECUTE FUNCTION bitacora_solo_insercion();

-- Confidencialidad: roles de BD
DO $$ BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname='sigev_api') THEN CREATE ROLE sigev_api NOLOGIN; END IF;
IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname='sigev_analitica') THEN CREATE ROLE sigev_analitica NOLOGIN; END IF;
IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname='sigev_soporte') THEN CREATE ROLE sigev_soporte NOLOGIN; END IF; END $$;
GRANT USAGE ON SCHEMA sigev TO sigev_api, sigev_analitica, sigev_soporte;
GRANT SELECT, INSERT, UPDATE ON personas, telefonos_persona, cuentas, asignaciones, consentimientos, recintos, puertas, eventos, tipos_entrada, lotes_carga, entradas TO sigev_api;
GRANT DELETE ON telefonos_persona TO sigev_api;
GRANT SELECT ON roles TO sigev_api;
GRANT SELECT, INSERT ON registros_ingreso, bitacora TO sigev_api;
GRANT SELECT ON eventos, tipos_entrada, recintos, puertas, registros_ingreso TO sigev_analitica;
GRANT SELECT (id, tipo_entrada_id, estado, emitida_en) ON entradas TO sigev_analitica;
GRANT SELECT ON bitacora, asignaciones, roles TO sigev_soporte;

-- Confidencialidad: seguridad por filas (RLS). La API fija app.persona_id por sesión.
ALTER TABLE entradas ENABLE ROW LEVEL SECURITY;
CREATE POLICY entradas_titular_pol ON entradas FOR SELECT TO sigev_api USING (titular_id = current_setting('app.persona_id', true)::uuid OR current_setting('app.rol', true) IN ('organizador','validador','superadmin'));
CREATE POLICY entradas_escritura_pol ON entradas FOR INSERT TO sigev_api WITH CHECK (true);
CREATE POLICY entradas_estado_pol ON entradas FOR UPDATE TO sigev_api USING (current_setting('app.rol', true) IN ('validador','organizador','superadmin'));
ALTER TABLE personas ENABLE ROW LEVEL SECURITY;
CREATE POLICY personas_propia_pol ON personas FOR ALL TO sigev_api USING (id = current_setting('app.persona_id', true)::uuid OR current_setting('app.rol', true) IN ('organizador','superadmin'));
