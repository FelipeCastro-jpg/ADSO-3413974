# B4 · Diccionario de datos · esquema `sigev`

**Motor:** PostgreSQL 16. **Fuente única:** este diccionario, el script [`B5-script-sigev.sql`](B5-script-sigev.sql) y el diagrama [`B2-modelo-logico.png`](B2-modelo-logico.png) se generan de la misma especificación, así que coinciden al 100 %.

**Estándar de nombrado:**
- Tablas en **plural** y `snake_case`.
- Llave primaria `id` de tipo **UUID** (aleatoria: no revela cuántos registros hay ni su orden). Excepciones: las tablas débiles e intermedias, con PK compuesta, y las de alto volumen (`registros_ingreso`, `bitacora`), con `BIGINT` de identidad para conservar el orden temporal.
- Llave foránea `<entidad>_id`, o un nombre de rol: `organizador_id`, `titular_id`, `validador_id`, `cargado_por`, `asignado_por`.
- Restricciones `<tabla>_<campo>_<pk|fk|uq|ck>`.

**Totales:** 14 tablas · 77 columnas.

### `personas`

Personas inscritas (con o sin cuenta); dato personal.

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK, DEFAULT gen_random_uuid() | Identificador aleatorio (no revela el orden de registro) |
| `tipo_doc` | CHAR | 2 | NOT NULL, CHECK | CC, CE, TI, PA |
| `numero_doc` | VARCHAR | 20 | NOT NULL, UNIQUE con tipo_doc | Documento de identidad |
| `nombre_completo` | VARCHAR | 150 | NOT NULL | Nombres y apellidos |
| `correo_contacto` | VARCHAR | 150 | NOT NULL, CHECK formato | Correo con @ |
| `creado_en` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Fecha de inscripción |

### `telefonos_persona`

Teléfonos de una persona (atributo multivaluado).

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `persona_id` | UUID | 16 bytes | PK, FK → personas.id, ON DELETE CASCADE | Persona existente |
| `numero` | VARCHAR | 15 | PK, CHECK solo dígitos | 7 a 15 dígitos |

### `cuentas`

Cuentas de acceso al sistema.

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK | Identificador |
| `persona_id` | UUID | 16 bytes | FK → personas.id, NOT NULL, UNIQUE (1:1), ON DELETE RESTRICT | Dueño de la cuenta |
| `correo_acceso` | VARCHAR | 150 | NOT NULL, UNIQUE | Usuario de inicio de sesión |
| `hash_clave` | VARCHAR | 100 | NOT NULL | Hash bcrypt o Argon2id con sal incluida |
| `intentos_fallidos` | SMALLINT | n/a | NOT NULL, DEFAULT 0, CHECK 0–5 | Al llegar a 5 se bloquea |
| `estado` | VARCHAR | 10 | NOT NULL, DEFAULT 'activa', CHECK | activa, bloqueada, cerrada |

### `roles`

Roles de negocio.

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `codigo` | VARCHAR | 15 | PK, CHECK | superadmin, organizador, validador, asistente |
| `nombre` | VARCHAR | 40 | NOT NULL | Nombre visible |
| `permisos` | TEXT[] | n/a | NOT NULL, DEFAULT vacío | Lista de códigos de permiso del rol |

### `asignaciones`

Asignación de roles a cuentas (resuelve N:M cuentas–roles).

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `cuenta_id` | UUID | 16 bytes | PK, FK → cuentas.id, ON DELETE CASCADE | Cuenta existente |
| `rol_codigo` | VARCHAR | 15 | PK, FK → roles.codigo, ON UPDATE CASCADE | Rol existente |
| `fecha_asignacion` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento de la asignación |
| `asignado_por` | UUID | 16 bytes | FK → cuentas.id, NULL, ON DELETE SET NULL | Superadmin que asignó |
| `vigente` | BOOLEAN | n/a | NOT NULL, DEFAULT true | false = revocada |

### `consentimientos`

Autorizaciones de tratamiento de datos (Ley 1581).

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK | Identificador |
| `persona_id` | UUID | 16 bytes | FK → personas.id, NOT NULL, ON DELETE RESTRICT | Titular |
| `version_politica` | VARCHAR | 10 | NOT NULL | Versión aceptada |
| `otorgado_en` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento de la autorización |
| `revocado_en` | TIMESTAMPTZ | n/a | NULL, CHECK ≥ otorgado_en | Vacío si sigue vigente |

### `recintos`

Lugares de los eventos.

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK | Identificador |
| `nombre` | VARCHAR | 100 | NOT NULL, UNIQUE | Nombre |
| `direccion` | VARCHAR | 150 | NOT NULL | Dirección |
| `capacidad_fisica` | INTEGER | n/a | NOT NULL, CHECK > 0 | Personas máximas del lugar |

### `puertas`

Puertas de un recinto (entidad débil).

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `recinto_id` | UUID | 16 bytes | PK, FK → recintos.id, ON DELETE CASCADE | Recinto dueño |
| `nro_puerta` | SMALLINT | n/a | PK (discriminante), CHECK > 0 | 1, 2, 3… dentro del recinto |
| `nombre` | VARCHAR | 40 | NOT NULL | Ej. Norte, VIP |
| `habilitada` | BOOLEAN | n/a | NOT NULL, DEFAULT true | Si está en uso |

### `eventos`

Eventos programados.

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK | Identificador |
| `recinto_id` | UUID | 16 bytes | FK → recintos.id, NOT NULL, ON DELETE RESTRICT | Recinto |
| `organizador_id` | UUID | 16 bytes | FK → cuentas.id, NOT NULL, ON DELETE RESTRICT | Cuenta organizadora |
| `titulo` | VARCHAR | 150 | NOT NULL | Título |
| `inicia_en` | TIMESTAMPTZ | n/a | NOT NULL | Inicio |
| `termina_en` | TIMESTAMPTZ | n/a | NOT NULL, CHECK > inicia_en | Fin |
| `aforo_maximo` | INTEGER | n/a | NOT NULL, CHECK > 0 | ≤ capacidad del recinto (regla en el dominio) |
| `estado` | VARCHAR | 12 | NOT NULL, DEFAULT 'programado', CHECK | programado, en_curso, cerrado, cancelado |

### `tipos_entrada`

Tipos de entrada de un evento.

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK | Identificador |
| `evento_id` | UUID | 16 bytes | FK → eventos.id, NOT NULL, ON DELETE CASCADE | Evento |
| `nombre` | VARCHAR | 40 | NOT NULL, UNIQUE con evento_id | General, VIP… |
| `cupo` | INTEGER | n/a | NOT NULL, CHECK > 0 | Entradas disponibles |
| `precio` | NUMERIC | 10,2 | NOT NULL, CHECK ≥ 0 | Pesos colombianos |

### `lotes_carga`

Archivos de carga masiva de asistentes (RF11).

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK | Identificador |
| `evento_id` | UUID | 16 bytes | FK → eventos.id, NOT NULL, ON DELETE CASCADE | Evento destino |
| `cargado_por` | UUID | 16 bytes | FK → cuentas.id, NOT NULL, ON DELETE RESTRICT | Organizador |
| `nombre_archivo` | VARCHAR | 120 | NOT NULL | Nombre del archivo |
| `filas_leidas` | INTEGER | n/a | NOT NULL, CHECK ≥ filas_rechazadas | Total de filas |
| `filas_rechazadas` | INTEGER | n/a | NOT NULL, DEFAULT 0, CHECK ≥ 0 | Filas con error |
| `cargado_en` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento de la carga |

### `entradas`

Entradas emitidas.

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | UUID | 16 bytes | PK | Identificador |
| `codigo` | VARCHAR | 32 | NOT NULL, UNIQUE | Código impreso |
| `tipo_entrada_id` | UUID | 16 bytes | FK → tipos_entrada.id, NOT NULL, ON DELETE RESTRICT | Tipo |
| `titular_id` | UUID | 16 bytes | FK → personas.id, NOT NULL, ON DELETE RESTRICT | Persona titular |
| `lote_id` | UUID | 16 bytes | FK → lotes_carga.id, NULL, ON DELETE SET NULL | Lote de origen, si vino por carga masiva |
| `estado` | VARCHAR | 10 | NOT NULL, DEFAULT 'vigente', CHECK | vigente, usada, anulada |
| `emitida_en` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento de emisión |

### `registros_ingreso`

Cada paso por una puerta (entrada o salida).

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | BIGINT | n/a | PK, identidad (alto volumen, orden temporal) | Consecutivo |
| `entrada_id` | UUID | 16 bytes | FK → entradas.id, NOT NULL, ON DELETE RESTRICT | Entrada leída |
| `recinto_id` | UUID | 16 bytes | FK (con nro_puerta) → puertas, NOT NULL | Recinto de la puerta |
| `nro_puerta` | SMALLINT | n/a | FK (con recinto_id) → puertas, NOT NULL | Puerta |
| `validador_id` | UUID | 16 bytes | FK → cuentas.id, NOT NULL, ON DELETE RESTRICT | Cuenta validadora |
| `sentido` | CHAR | 1 | NOT NULL, CHECK | E = entrada, S = salida |
| `resultado` | VARCHAR | 9 | NOT NULL, CHECK | aceptado, rechazado |
| `motivo` | VARCHAR | 60 | NULL; obligatorio si rechazado | Ej. entrada ya usada |
| `ocurrido_en` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento |

### `bitacora`

Auditoría de solo inserción (RF12).

| Columna | Tipo | Tamaño | Restricciones | Dominio |
|---|---|---|---|---|
| `id` | BIGINT | n/a | PK, identidad | Consecutivo |
| `cuenta_id` | UUID | 16 bytes | FK → cuentas.id, NULL, ON DELETE SET NULL | Quién hizo la acción (vacío = sistema) |
| `comando` | VARCHAR | 40 | NOT NULL | Ej. AsignarRol, CargarLote, ControlIngreso |
| `detalle` | JSONB | n/a | NOT NULL | Datos de la acción (sin claves ni documentos completos) |
| `huella` | CHAR | 64 | NOT NULL, UNIQUE | SHA-256 encadenado con el registro anterior |
| `ocurrido_en` | TIMESTAMPTZ | n/a | NOT NULL, DEFAULT now() | Momento |
