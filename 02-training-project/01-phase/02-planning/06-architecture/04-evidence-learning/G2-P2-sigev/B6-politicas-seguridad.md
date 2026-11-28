# B6 · Políticas de seguridad de los datos

Implementadas o declaradas en [`B5-script-sigev.sql`](B5-script-sigev.sql) y probadas en [`B5-evidencia-ejecucion.log`](B5-evidencia-ejecucion.log).

| # | Principio | Política concreta | Dónde |
|---|---|---|---|
| S1 | Integridad | **Bitácora de solo inserción:** el disparador `bitacora_sin_cambios` rechaza UPDATE y DELETE; la columna `huella` (SHA-256 encadenado) es única | Script (probado en el log) |
| S2 | Integridad | **Reglas del negocio en la base:** máximo 5 intentos fallidos (`cuentas_intentos_ck`), un rechazo exige motivo (`registros_motivo_ck`), una persona no tiene dos entradas del mismo tipo (`entradas_titular_tipo_uq`), una carga no puede tener más filas rechazadas que leídas (`lotes_filas_ck`) | 19 CHECK y 8 UNIQUE |
| S3 | Integridad | **Llave foránea compuesta** hacia `puertas`: no se registra un ingreso por una puerta que no existe | `registros_puerta_fk` |
| S4 | Confidencialidad | **Contraseñas con hash y sal:** `cuentas.hash_clave` guarda Argon2id (la sal va incluida en el valor). Nunca se cifran de forma reversible | Componente de autenticación |
| S5 | Confidencialidad | **Seguridad por filas (RLS):** con el rol `sigev_api`, un asistente solo ve **sus** entradas y **su** fila de `personas`; los organizadores y validadores ven lo de su función | Políticas `entradas_titular_pol` y `personas_propia_pol` (probadas: otra persona ve 0 entradas ajenas) |
| S6 | Confidencialidad | **TLS 1.3** en el balanceador y **TLS** interno hacia PostgreSQL (5432) y Redis (6380) | Despliegue A6 |
| S7 | Confidencialidad | **Analítica sin datos personales:** `sigev_analitica` no puede leer `personas` ni `cuentas`, y de `entradas` solo ve id, tipo, estado y fecha | `GRANT` por columna |
| S8 | Disponibilidad | **Respaldos:** PostgreSQL gestionado con recuperación a un punto en el tiempo (7 días) + exportación lógica **diaria a las 03:00** al almacenamiento de objetos, con **retención de 35 días** | Despliegue A6 |
| S9 | Disponibilidad | **Prueba de restauración cada 15 días:** se restaura la última copia en una base de prueba y se verifica la cadena de huellas de la bitácora. **RPO ≤ 5 min · RTO ≤ 30 min** | Procedimiento de operación |
| S10 | Disponibilidad | **Multi-zona:** primaria y réplica en espera en zonas distintas, con conmutación automática. Si Redis cae, el contador se reconstruye desde `registros_ingreso` | Despliegue A6 |

## Datos personales (Ley 1581 de 2012)

| Aspecto | Medida |
|---|---|
| Datos tratados | `personas` (documento, nombre, correo), `telefonos_persona`, las fotos de verificación (en el almacenamiento de objetos, cifradas) |
| Finalidad | Inscripción al evento, emisión de la entrada, control de ingreso y avisos de seguridad. Se informa al inscribirse |
| Autorización | `consentimientos`: versión de la política y fecha. Las personas cargadas por archivo reciben un correo para autorizar antes de usar su entrada |
| Revocatoria | `consentimientos.revocado_en`; se conservan los registros de ingreso por auditoría (FK `RESTRICT`) |

## Matriz de roles contra tablas

**Roles de negocio** (a través de la API con RLS):

| Tabla | Superadmin | Organizador | Validador | Asistente |
|---|---|---|---|---|
| personas | Leer y editar | Leer (inscritos de sus eventos) | Leer nombre (vía entrada) | Leer y editar la propia |
| cuentas | Leer y bloquear | – | – | Leer y editar la propia |
| roles, asignaciones | Todo | Leer | Leer | – |
| recintos, puertas | Todo | Leer | Leer | Leer |
| eventos, tipos_entrada | Leer | Crear y editar los propios | Leer el asignado | Leer los publicados |
| lotes_carga | Leer | Crear y leer los propios | – | – |
| entradas | Leer | Leer las de sus eventos | Leer y marcar como usada | Leer las propias |
| registros_ingreso | Leer | Leer los de sus eventos | Insertar y leer | Leer los de su entrada |
| bitacora | Leer | – | – | – |
| consentimientos | Leer | – | – | Leer, otorgar y revocar el propio |

**Roles de base de datos:**

| Rol | Uso | Permisos |
|---|---|---|
| `sigev_api` | La aplicación | SELECT, INSERT y UPDATE en las tablas operativas; **solo SELECT e INSERT en `registros_ingreso` y `bitacora`**; sujeto a RLS |
| `sigev_analitica` | Tablero y reportes | Solo SELECT, sin datos personales |
| `sigev_soporte` | Auditoría y soporte | Solo SELECT en `bitacora`, `asignaciones` y `roles` |
