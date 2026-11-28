# B7 · Lista de chequeo del diseño (P1 y P2)

Severidad:
- **C (crítico):** rompe un requisito o la integridad.
- **M (mayor):** afecta la calidad o la trazabilidad.
- **m (menor):** afecta la presentación.

| ID | Artefacto | Criterio medible | Sev. | Cumple | Evidencia |
|---|---|---|---|---|---|
| V-01 | Clases | ≥ 8 clases con tipos y visibilidad en todos los atributos | M | Sí | 22 clases en A2 |
| V-02 | Clases | Multiplicidad en ambos extremos de cada asociación | m | Sí | 8 asociaciones con multiplicidad |
| V-03 | Clases | Hay ≥ 1 composición y ≥ 1 agregación usadas con criterio | M | Sí | Evento ◆ TipoEntrada; InvocadorComandos ◇ ComandoAdministrativo |
| V-04 | Clases | Hay interfaces con ≥ 2 implementaciones | M | Sí | ComandoAdministrativo (3), FabricaReporte (2) |
| V-05 | Clases | Ninguna clase mezcla presentación, negocio, persistencia y notificación | M | Sí | Comandos, fábricas y dominio separados; la persistencia vive en los adaptadores (A4) |
| V-06 | Trazabilidad | 100 % de los RF llegan a clase y componente; ninguna clase sin RF | M | Sí | A7: 13/13 RF y 22/22 clases |
| V-07 | Patrones | 2 patrones GoF distintos (no Singleton), visibles en el diagrama | M | Sí | Comando y Fábrica abstracta en A2 |
| V-08 | Arquitectura | Las dependencias apuntan al núcleo; el dominio no depende de adaptadores | C | Sí | A4 y A5: los adaptadores implementan puertos |
| V-09 | Arquitectura | ≥ 3 RNF con decisión y alternativa descartada | M | Sí | 5 filas en A4 |
| V-10 | Componentes | ≥ 5 componentes con interfaces provistas y requeridas | M | Sí | 12 componentes y 11 interfaces |
| V-11 | Despliegue | ≥ 3 nodos con protocolo y puerto en cada conexión | m | Sí | 8 nodos; 443, 8080, 5432, 6380 |
| V-12 | Despliegue | ≥ 1 decisión de despliegue por RNF | M | Sí | Multi-zona (RNF-03), Redis (RNF-04), autoescalado (RNF-05) |
| V-13 | Conceptual | ≥ 6 entidades; ≥ 1 N:M y ≥ 1 1:N; (mín, máx) en cada extremo | C | Sí | 11 entidades; CUENTA–ROL N:M |
| V-14 | Lógico | Toda tabla tiene PK y toda relación 1:N tiene FK | C | Sí | 14 PK y 19 FK (log) |
| V-15 | Lógico | Cada N:M tiene tabla intermedia | C | Sí | `asignaciones` |
| V-16 | Lógico | El multivaluado está en una tabla aparte | C | Sí | `telefonos_persona` |
| V-17 | Normalización | 2 tablas de 0FN a 3FN con DF escritas (una con llave compuesta y una con transitiva) | M | Sí | B3: CSV de carga y reporte |
| V-18 | Normalización | Toda desnormalización está justificada | M | Sí | `roles.permisos` (B2) |
| V-19 | Diccionario | 100 % de las columnas con tipo, tamaño, restricciones y dominio | M | Sí | 77/77 en B4 |
| V-20 | Diccionario | Nombres y tipos iguales en el script | M | Sí | Se generan de la misma especificación |
| V-21 | Script | Ejecuta sin errores en un motor real | C | Sí | Log: PostgreSQL 16.15, código de salida 0 |
| V-22 | Script | ≥ 3 CHECK y ≥ 3 FK con `ON DELETE` | M | Sí | 19 CHECK; CASCADE, RESTRICT y SET NULL |
| V-23 | Script | Las pruebas negativas fallan como se espera | M | Sí | 8 errores esperados en el log |
| V-24 | Seguridad | ≥ 2 políticas por principio, sobre tablas reales | M | Sí | S1–S10 |
| V-25 | Seguridad | Contraseñas con hash y sal; tráfico por TLS | C | Sí | S4 (Argon2id), S6 |
| V-26 | Seguridad | Un asistente no puede ver entradas ajenas | C | Sí | Prueba RLS: 0 entradas visibles para otra persona |

## Hallazgos y correcciones

| ID | Artefacto | Hallazgo | Requisito | Sev. | Corrección |
|---|---|---|---|---|---|
| H-1 | Conceptual | El MER de G1 tenía ASIGNACIÓN como entidad, lo que corresponde a un modelo ya resuelto | RF4 | M | En B1 quedó como N:M con atributos; la tabla aparece en B2 |
| H-2 | Lógico | En el primer borrador del modelo lógico, `registros_ingreso` guardaba solo `nro_puerta`, sin el recinto; dos recintos con «Puerta 1» quedaban indistinguibles | RF8 | C | FK compuesta `(recinto_id, nro_puerta)` hacia `puertas` |
| H-3 | Lógico | Nada impedía emitir dos entradas del mismo tipo a la misma persona (doble carga del CSV) | RF11 | M | `UNIQUE (titular_id, tipo_entrada_id)`, probado en el log |
| H-4 | Conceptual | El rombo «es titular de» quedó encima de CONSENTIMIENTO y la relación PERSONA–CONSENTIMIENTO no estaba dibujada | Calidad | m | Se reubicó el rombo y se agregó la relación «autoriza» |
| H-5 | Lógico | Algunas líneas del diagrama lógico cruzaban por encima de las tablas | Calidad | m | Se rutearon por los pasillos entre tablas |
