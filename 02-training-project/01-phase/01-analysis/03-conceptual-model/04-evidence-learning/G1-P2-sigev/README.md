# G1-P2 · Modelo de análisis y verificación · SIGEV

## 1. Datos de la entrega

- **Producto:** P2 · modelo de análisis y verificación
- **Usuario de GitHub del autor:** FelipeCastro-jpg
- **Caso de estudio:** SIGEV (EventFlow Manager)
- **Trabajo en equipo del año:** sí (equipo de 2). El SRS es compartido; los casos críticos, plantillas, diagramas, dominio, MER, prototipo y verificación de esta carpeta son individuales y distintos de los de mi compañera.

## 2. Qué reutilicé

| Artefacto | Origen | ¿Solo o en equipo? |
|---|---|---|
| Requisitos RF1–RF13 y RNF del SRS | SRS del equipo (GA1-37371-AA2-EV01) | En equipo |
| Catálogo de casos de uso | `../G1-P1-sigev/` | Individual |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Commit |
|---|---|---|---|
| 1 | PL-A08 | Agregué los alternos 4a y 4b para que coincidan con el diagrama de actividades (C2) | https://github.com/FelipeCastro-jpg/ADSO-3413974/commit/8561cc2 |
| 2 | Dominio | Agregué LoteCarga, LíneaCarga y Puerta, que las plantillas usaban (C3) | https://github.com/FelipeCastro-jpg/ADSO-3413974/commit/8561cc2 |
| 3 | PL-A15 | Reclasifiqué «ocupación al 100 %» de excepción a alterno (C2, regla 4) | https://github.com/FelipeCastro-jpg/ADSO-3413974/commit/8561cc2 |
| 4 | AD-A15 | Agregué el nodo de fusión antes de «Revisar la alerta» (C1) | https://github.com/FelipeCastro-jpg/ADSO-3413974/commit/8561cc2 |
| 5 | MER | Unifiqué la convención de cardinalidades Chen (C4) | https://github.com/FelipeCastro-jpg/ADSO-3413974/commit/8561cc2 |

## 4. Qué construí nuevo

- Plantillas de CU-A05, CU-A08 y CU-A15.
- Diagramas de actividades de CU-A08 (con bifurcación y unión) y CU-A15 (ciclo).
- Dominio de 15 clases con clase de asociación.
- MER en notación Chen con entidad débil.
- 3 pantallas.
- Lista de 17 criterios, 5 ajustes, informe y matriz.

## 5. Artefactos entregados

- [x] Diagramas de actividades (2): [AD-A08](actividades-CUA08-cargar-asistentes.drawio) · [AD-A15](actividades-CUA15-supervisar-aforo.drawio) (+ `.png`)
- [x] Plantillas extendidas (3): [01-plantillas-extendidas.md](01-plantillas-extendidas.md)
- [x] Modelo de dominio: [modelo-dominio.drawio](modelo-dominio.drawio) · [.png](modelo-dominio.png)
- [x] MER (Chen): [modelo-entidad-relacion.drawio](modelo-entidad-relacion.drawio) · [.png](modelo-entidad-relacion.png)
- [x] Prototipo (3 pantallas): [P1](mockup-P1-CUA05-roles-permisos.png) · [P2](mockup-P2-CUA08-cargar-asistentes.png) · [P3](mockup-P3-CUA15-aforo-en-vivo.png)
- [x] Lista de chequeo (17) y registro de ajustes (5): [02-verificacion-y-ajustes.md](02-verificacion-y-ajustes.md)
- [x] Informe de análisis: [03-informe-analisis.md](03-informe-analisis.md)
- [x] Matriz de trazabilidad: [04-matriz-trazabilidad.md](04-matriz-trazabilidad.md)

## 6. Declaración de autoría

- [x] El ajuste y lo construido nuevo en esta carpeta es mi trabajo individual.
- [x] Lo tomado del equipo (el SRS) está en la sección 2.
- [x] Entiendo la verificación oral del sábado 28 y su tope de 50.

Firma: FelipeCastro-jpg · 27/11/2026

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Claude (Anthropic) | Para generar los `.drawio` y las pantallas, y redactar borradores de las plantillas, la lista de chequeo, el informe y la matriz | Claude generó los diagramas y la redacción. Yo revisé que cada rama de los diagramas de actividades esté en su plantilla, que el MER tenga la entidad débil PUERTA y la asociativa ASIGNACIÓN, y que puedo explicar por qué elegí esos 3 casos críticos. |

## 8. Autocontrol

- [x] Commits en 2 días distintos.
- [x] Sin material del instructor ni de otras personas.
- [x] Push verificado en GitHub.
