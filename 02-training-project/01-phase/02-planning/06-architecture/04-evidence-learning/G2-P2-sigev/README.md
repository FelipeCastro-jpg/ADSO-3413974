# README · Guía 2 · Producto 2: modelo de datos y verificación

## 1. Datos

| Campo | Valor |
|---|---|
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub | FelipeCastro-jpg |
| Ficha | 3413974 |
| Caso | SIGEV (EventFlow Manager), el mismo de P1 |
| Análisis | `../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigev/03-informe-analisis.md` |

## 2. Insumo y equipo

El SRS es del equipo (2 aprendices). Mi MER de partida es individual (G1-P2). Los artefactos de esta carpeta son míos y distintos de los de mi compañera: llaves UUID, notación Chen, RLS, otras tablas normalizadas y otras políticas.

## 3. Qué reutilicé, ajusté e hice nuevo

| Artefacto | Archivo | Origen | Ajuste |
|---|---|---|---|
| B1 | `B1-modelo-conceptual.*` | Mi MER Chen de `.../G1-P2-sigev/` | Dejé CUENTA–ROL como N:M con atributos; agregué LOTE_CARGA, CONSENTIMIENTO y el teléfono multivaluado |
| B2 | `B2-modelo-logico.*`, `B1-B2-B3-…md` | nuevo | 14 tablas, cuadro de 7 reglas, FK compuesta a puertas |
| B3 | `B1-B2-B3-…md` | nuevo | CSV de carga (llave compuesta) y reporte (transitiva) |
| B4 | `B4-diccionario-datos.md` | nuevo | 77 columnas |
| B5 | `B5-script-sigev.sql`, `B5-pruebas-sigev.sql`, `B5-evidencia-ejecucion.log` | nuevo | PostgreSQL 16.15 sin errores; RLS; 8 pruebas negativas |
| B6 | `B6-politicas-seguridad.md` | RNF del SRS | 10 políticas, matriz de 4 roles de negocio + 3 de BD |
| B7 | `B7-lista-chequeo.md` | nuevo | 26 criterios con severidad, 5 hallazgos |

## 4. Autoverificación

- [x] B1: 11 entidades, N:M y 1:N, (mín, máx)
- [x] B2: 14 tablas con PK/FK y cuadro de reglas
- [x] B3: 2 tablas de 0FN a 3FN (compuesta y transitiva)
- [x] B4: diccionario completo
- [x] B5: script ejecutado (log) y `ON DELETE` en ≥ 3 FK
- [x] B6: 10 políticas, hash y sal, TLS, matriz de roles
- [x] B7: 26 criterios sobre P1 y P2

## 5. Historial de commits

| Jueves 26/11/2026 | Add files via upload (modelo conceptual, lógico y script SQL) |
| Viernes 27/11/2026 | Add files via upload (carpeta completa con diccionario, normalización, políticas y lista de chequeo) |

## 6. Uso de IA

| Herramienta | Para qué | Qué verifiqué o cambié |
|---|---|---|
| Claude (Anthropic) | Para generar el script, el diccionario y los diagramas a partir de una especificación, ejecutar el script en PostgreSQL y redactar borradores | (Claude generó el script, el diccionario y los diagramas y ejecutó el script en PostgreSQL. Yo revisé el log de ejecución, entendí cómo se llega a 3FN con el CSV de carga y para qué sirve la seguridad por filas (RLS).) |

## 7. Cómo reproducir

```bash
createdb sigev_db
psql -v ON_ERROR_STOP=1 -d sigev_db -f B5-script-sigev.sql
psql -d sigev_db -f B5-pruebas-sigev.sql   # los ERROR son esperados
```

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo reutilizado está en la sección 3 y que puedo explicarlos en la verificación oral.

Usuario de GitHub: FelipeCastro-jpg · Fecha: 27/11/2026
