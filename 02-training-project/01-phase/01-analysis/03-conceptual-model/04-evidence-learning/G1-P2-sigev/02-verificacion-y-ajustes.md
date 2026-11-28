# 2. Lista de chequeo y registro de ajustes

## 2.1 Lista de chequeo (Anexo B)

- **Primera verificación:** 26/11/2026, sobre los primeros borradores.
- **Segunda verificación:** 27/11/2026, después de los ajustes.
- Los criterios 1 a 4 son de **cobertura o trazabilidad**.

| # | Criterio verificable | Artefacto | 1.ª | 2.ª | Evidencia | Hallazgo |
|---|---|---|---|---|---|---|
| 1 | Los 13 RF aparecen en al menos un caso de uso | Matriz RF→CU (P1) | Sí | Sí | `../G1-P1-sigev/04-matriz-rf-cu.md`: 13/13 | – |
| 2 | Los RF de los 3 casos críticos llegan hasta plantilla, clase y entidad | Matriz de trazabilidad | Sí | Sí | `04-matriz-trazabilidad.md` | – |
| 3 | Cada rama de los diagramas de actividades está en la plantilla del mismo caso | Actividades y plantillas | No | Sí | AD-A08: 2a, 4a, 4b, 5a · AD-A15: 5a, 5b | A1 |
| 4 | Todo concepto de las plantillas existe en el modelo de dominio | Plantillas y dominio | No | Sí | «Lote», «línea de carga», «puerta» son clases | A2 |
| 5 | Cada plantilla tiene ≥ 6 pasos, ≥ 1 alterno y ≥ 1 excepción | Plantillas | Sí | Sí | PL-A05, PL-A08 y PL-A15, cada una con 8 pasos | – |
| 6 | Las excepciones impiden el objetivo y los alternos terminan con éxito | Plantillas | No | Sí | PL-A15: llegar al 100 % pasó de excepción a alterno 5b | A3 |
| 7 | Las plantillas no tienen detalles de implementación | Plantillas | Sí | Sí | No nombran tablas, lenguajes ni servicios | – |
| 8 | Toda decisión tiene guardas que cubren todas sus salidas | Actividades | Sí | Sí | AD-A15: [= 100 %] / [80–99 %] / [< 80 %] | – |
| 9 | Ninguna acción recibe dos flujos sin un nodo de fusión | Actividades | No | Sí | AD-A15: fusión antes de «Revisar la alerta» | A4 |
| 10 | Hay calles por actor e inicio y fin en cada diagrama | Actividades | Sí | Sí | AD-A08: 3 calles; AD-A15: 2 calles | – |
| 11 | El dominio tiene ≥ 8 clases, sin métodos ni claves | Dominio | Sí | Sí | 15 clases, solo con atributos | – |
| 12 | El dominio tiene una generalización o una clase de asociación | Dominio | Sí | Sí | Clase de asociación Asignación | – |
| 13 | El MER declara su notación y tiene ≥ 6 entidades con identificador | MER | Sí | Sí | Notación Chen, 10 entidades con PK | – |
| 14 | La N:M está resuelta con una entidad asociativa con atributos propios | MER | Sí | Sí | ASIGNACIÓN (fecha, responsable, vigente) | – |
| 15 | Hay una entidad débil o una relación recursiva | MER | Sí | Sí | PUERTA, débil de RECINTO | – |
| 16 | Las cardinalidades del MER siguen la convención declarada | MER | No | Sí | (mín, máx) junto a cada entidad = participación | A5 |
| 17 | Cada pantalla está rotulada con su caso de uso | Prototipo | Sí | Sí | P1 CU-A05, P2 CU-A08, P3 CU-A15 | – |

**Resumen:** primera verificación 12/17 (71 %) → segunda verificación **17/17 (100 %)**.

## 2.2 Registro de ajustes (Anexo D)

| # | Hallazgo | Artefacto | Antes | Después | Commit | ¿Se verificó de nuevo? |
|---|---|---|---|---|---|---|
| A1 | Criterio 3: una rama del diagrama no estaba en la plantilla | PL-A08 | La plantilla no tenía la decisión del organizador entre corregir o cargar solo las filas válidas | Se agregaron los alternos 4a y 4b, con la misma numeración del diagrama | (pegar enlace) | Sí · 27/11 |
| A2 | Criterio 4: conceptos sin clase | Dominio | El SRS no tenía el concepto de «carga» ni de «puerta» como objetos | Clases LoteCarga ◆ LíneaCarga y Puerta | (pegar enlace) | Sí · 27/11 |
| A3 | Criterio 6: alterno y excepción confundidos | PL-A15 | «Ocupación al 100 %» estaba como excepción, pero el caso sigue y termina bien (se bloquea y se supervisa) | Pasó a ser el alterno 5b; la excepción real es la pérdida de conexión (3a) | (pegar enlace) | Sí · 27/11 |
| A4 | Criterio 9: dos flujos llegaban directo a una acción | AD-A15 | Las alertas de 80 % y 100 % entraban directo a «Revisar la alerta» (en UML eso es una espera de ambas) | Nodo de fusión antes de la acción | (pegar enlace) | Sí · 27/11 |
| A5 | Criterio 16: convención de cardinalidad mezclada | MER | Algunas (mín, máx) estaban en el lado opuesto, como en pata de gallo | Todas siguen la convención Chen de participación (ej. ROL (0,N) — ASIGNACIÓN (1,1)) | (pegar enlace) | Sí · 27/11 |
