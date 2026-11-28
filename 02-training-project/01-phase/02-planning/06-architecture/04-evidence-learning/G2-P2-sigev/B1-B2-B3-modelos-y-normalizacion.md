# B1 · Modelo conceptual · B2 · Modelo lógico · B3 · Normalización

## B1 · Modelo conceptual (Chen)

Diagrama: [`B1-modelo-conceptual.png`](B1-modelo-conceptual.png) · fuente: [`.drawio`](B1-modelo-conceptual.drawio)

**Tipo de base de datos:** relacional (PostgreSQL), por las transacciones del ingreso y del cupo y por la seguridad por filas para los datos personales. Redis solo guarda el contador temporal del aforo (ver A1).

| Entidad | Identificador | RF |
|---|---|---|
| PERSONA (con teléfono multivaluado) | id_persona | RF1, RF11 |
| CUENTA | id_cuenta | RF2, RF3 |
| ROL | cod_rol | RF4 |
| CONSENTIMIENTO | id_consentimiento | RF1 |
| RECINTO | id_recinto | RF5 |
| PUERTA (débil) | id_recinto + nro_puerta | RF8 |
| EVENTO | id_evento | RF5, RF7 |
| TIPO_ENTRADA | id_tipo | RF5, RF6 |
| ENTRADA | id_entrada | RF6 |
| REGISTRO_INGRESO | id_registro | RF7, RF8, RF13 |
| LOTE_CARGA | id_lote | RF11 |

**Relaciones:**
- **N:M:** CUENTA **desempeña** ROL (1,N)–(0,N), con atributos de relación.
- **1:N:** RECINTO alberga EVENTO · EVENTO ofrece TIPO_ENTRADA · TIPO clasifica ENTRADA · PERSONA es titular de ENTRADA · ENTRADA se usa en REGISTRO_INGRESO · PUERTA registra REGISTRO · CUENTA organiza EVENTO · CUENTA carga LOTE · LOTE destinado a EVENTO · LOTE origina ENTRADA · PERSONA autoriza CONSENTIMIENTO · RECINTO tiene PUERTA (identificadora).
- **1:1:** CUENTA «posee» PERSONA (una cuenta pertenece a una sola persona; una persona tiene como máximo una cuenta).

**Ajuste respecto a mi MER de G1:**
- En G1, ASIGNACIÓN era una entidad asociativa; en el conceptual la dejé como **N:M con atributos**, porque su resolución pertenece al lógico.
- Agregué LOTE_CARGA y CONSENTIMIENTO, que el RF11 y la Ley 1581 necesitan.
- Agregué el teléfono como atributo multivaluado.

## B2 · Modelo lógico

Diagrama: [`B2-modelo-logico.png`](B2-modelo-logico.png) · fuente: [`.drawio`](B2-modelo-logico.drawio). Son 14 tablas con PK y 19 FK.

| Regla de transformación | Caso | Resultado |
|---|---|---|
| Entidad → tabla con PK UUID | PERSONA, CUENTA, RECINTO, EVENTO, TIPO_ENTRADA, ENTRADA, LOTE_CARGA, CONSENTIMIENTO | `personas.id`, `cuentas.id`… `DEFAULT gen_random_uuid()` |
| **N:M → tabla intermedia** | CUENTA desempeña ROL | `asignaciones(cuenta_id, rol_codigo)` con PK compuesta y sus atributos `fecha_asignacion`, `asignado_por`, `vigente` |
| **1:N → FK en el lado «muchos»** | RECINTO–EVENTO, EVENTO–TIPO, TIPO–ENTRADA, PERSONA–ENTRADA, ENTRADA–REGISTRO, CUENTA–EVENTO, CUENTA–LOTE, LOTE–EVENTO, LOTE–ENTRADA, PERSONA–CONSENTIMIENTO | `eventos.recinto_id`, `entradas.titular_id`, `entradas.lote_id` (admite nulo)… |
| **1:1 → FK única** | CUENTA–PERSONA | `cuentas.persona_id UNIQUE` |
| **Entidad débil → PK compuesta** | PUERTA de RECINTO | `puertas(recinto_id, nro_puerta)`; `registros_ingreso` la referencia con una **FK compuesta** |
| **Multivaluado → tabla aparte** | Teléfonos de PERSONA | `telefonos_persona(persona_id, numero)` con PK compuesta |
| Lista de permisos del rol | Permisos de ROL | Columna `roles.permisos TEXT[]`. **Desnormalización justificada:** son 4 roles fijos, se leen juntos en cada petición y no se consultan por permiso. Una tabla `permisos` agregaría una unión en cada autorización sin beneficio. |

## B3 · Normalización paso a paso

### Tabla 1 · Archivo CSV de carga masiva (llave compuesta)

**0FN** (así llega el archivo del organizador, ya con el lote identificado):
`carga(lote_id, numero_fila, nombre_archivo, fecha_carga, evento_id, titulo_evento, tipo_doc, numero_doc, nombre, telefonos, tipo_entrada, precio_tipo)`

- Llave: (`lote_id`, `numero_fila`).
- `telefonos` viene como `"3001234567;6041234567"`.

| Paso | Violación | DF escritas | Resultado |
|---|---|---|---|
| 1FN | `telefonos` no es atómico | `(tipo_doc, numero_doc) → {telefono}` | `telefonos_persona(persona_id, numero)`; sale la columna |
| 2FN (dependencia **parcial**) | `nombre_archivo`, `fecha_carga`, `evento_id` y `titulo_evento` dependen **solo de `lote_id`** | `lote_id → nombre_archivo, fecha_carga, evento_id, titulo_evento` · `(lote_id, numero_fila) → tipo_doc, numero_doc, nombre, tipo_entrada` | `lotes_carga(id, nombre_archivo, cargado_en, evento_id, …)` y las filas por separado |
| 3FN (dependencia **transitiva**) | `titulo_evento` depende de `evento_id`; `nombre` depende de `(tipo_doc, numero_doc)`; `precio_tipo` depende de `tipo_entrada` | `lote_id → evento_id → titulo_evento` · `(tipo_doc, numero_doc) → nombre` · `(evento_id, tipo_entrada) → precio_tipo` | `eventos(id, titulo, …)`, `personas(id, tipo_doc, numero_doc, nombre_completo)`, `tipos_entrada(id, evento_id, nombre, precio)`. Cada fila válida termina como una `entradas(titular_id, tipo_entrada_id, lote_id)` |

### Tabla 2 · Reporte de asistencia exportado (dependencia transitiva)

**0FN:**
`reporte(registro_id, ocurrido_en, recinto_id, recinto_nombre, nro_puerta, puerta_nombre, entrada_codigo, numero_doc, nombre_persona, tipo_entrada, precio)`

- Llave: `registro_id`.

| Paso | Violación | DF escritas | Resultado |
|---|---|---|---|
| 1FN | Todos los valores son atómicos | – | Ya está en 1FN (se verifica) |
| 2FN | La llave es simple, así que no hay dependencias parciales | `registro_id → todos` | Ya está en 2FN |
| 3FN (**transitiva**) | Los datos de la entrada, la persona y el tipo dependen de `entrada_codigo`; los del recinto y la puerta dependen de `(recinto_id, nro_puerta)` | `registro_id → entrada_codigo → numero_doc, nombre_persona, tipo_entrada → precio` · `registro_id → (recinto_id, nro_puerta) → puerta_nombre` · `recinto_id → recinto_nombre` | `registros_ingreso(id, entrada_id, recinto_id, nro_puerta, …)` + `entradas`, `personas`, `tipos_entrada`, `puertas`, `recintos` |

**Resultado:** el modelo final no tiene dependencias parciales ni transitivas. La única desnormalización es `roles.permisos`, justificada arriba.
