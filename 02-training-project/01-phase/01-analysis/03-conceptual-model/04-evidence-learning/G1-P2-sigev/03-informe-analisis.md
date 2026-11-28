# 3. Informe de análisis · SIGEV

**Guía 1 · Producto 2** · Metodología: XP (ver G1-P1)

## Requisitos interpretados

- **13 funcionales**, que agrupo en tres frentes:
  - **Acceso y gobierno:** RF1–RF4 y RF13 (cuentas, roles, bloqueo y alertas de fraude).
  - **Operación del evento:** RF5, RF6, RF8 y RF11 (programar, emitir entradas, cargar asistentes, controlar ingreso).
  - **Control y seguimiento:** RF7, RF9, RF10 y RF12 (aforo, indicadores, reportes, bitácora).
- **10 no funcionales:** restricciones de calidad que no son casos de uso. Los más exigentes son:
  - escaneo en menos de 1,5 s (RNF-04);
  - disponibilidad de 99,8 % (RNF-03);
  - validación sin conexión (RNF-10);
  - Ley 1581 de 2012 (RNF-07).

  La matriz de G1-P1 dice qué caso restringe cada uno.

## Modelos producidos

| Modelo | Archivo | Qué aporta |
|---|---|---|
| Casos de uso (P1) | `../G1-P1-sigev/diagrama-casos-uso.drawio` | 18 casos, 5 «include», 4 «extend» |
| Plantillas extendidas | [`01-plantillas-extendidas.md`](01-plantillas-extendidas.md) | CU-A05, CU-A08, CU-A15 |
| Actividades CU-A08 | [`.drawio`](actividades-CUA08-cargar-asistentes.drawio) / [`.png`](actividades-CUA08-cargar-asistentes.png) | 4 decisiones y una bifurcación/unión |
| Actividades CU-A15 | [`.drawio`](actividades-CUA15-supervisar-aforo.drawio) / [`.png`](actividades-CUA15-supervisar-aforo.png) | Ciclo de supervisión con 3 niveles de ocupación |
| Modelo de dominio | [`.drawio`](modelo-dominio.drawio) / [`.png`](modelo-dominio.png) | 15 clases y la clase de asociación Asignación |
| MER (Chen) | [`.drawio`](modelo-entidad-relacion.drawio) / [`.png`](modelo-entidad-relacion.png) | 10 entidades, la entidad débil PUERTA y la asociativa ASIGNACIÓN |
| Prototipo | [P1](mockup-P1-CUA05-roles-permisos.png) · [P2](mockup-P2-CUA08-cargar-asistentes.png) · [P3](mockup-P3-CUA15-aforo-en-vivo.png) | Una pantalla por caso crítico |

## Resultado de la verificación

La lista de 17 criterios ([`02-verificacion-y-ajustes.md`](02-verificacion-y-ajustes.md)) dio **12/17 en la primera verificación**. No cumplían:
- el criterio **3**: una rama del diagrama no estaba en la plantilla;
- el criterio **4**: había conceptos sin clase;
- el criterio **6**: un alterno estaba clasificado como excepción;
- el criterio **9**: faltaba un nodo de fusión;
- el criterio **16**: la convención de cardinalidad estaba mezclada.

Después de los ajustes, la segunda verificación dio **17/17**.

## Ajustes realizados

5 ajustes con antes y después (A1 a A5), todos verificados de nuevo.

## Trazabilidad

En [`04-matriz-trazabilidad.md`](04-matriz-trazabilidad.md), el **100 %** de los RF llega hasta caso de uso, clase y entidad. Los 3 casos críticos llegan además a plantilla, diagrama de actividades y pantalla.

**Pendiente para diseño (G2):** pasar el MER al modelo lógico con llaves UUID, decidir la arquitectura (hexagonal) y convertir las reglas RN-A1 a RN-A7 en restricciones.
