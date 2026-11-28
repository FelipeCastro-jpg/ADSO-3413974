# G1-P1 · Plan de análisis y casos de uso · SIGEV

> **Antes de subir:** cambia `TU_USUARIO_GITHUB` por tu usuario de GitHub (aparece 2 veces).

## 1. Datos de la entrega

- **Producto:** P1 · plan de análisis y casos de uso
- **Usuario de GitHub del autor:** TU_USUARIO_GITHUB
- **Caso de estudio:** SIGEV (EventFlow Manager): gestión de eventos, entradas con QR, control de ingreso y aforo
- **Trabajo en equipo del año:** sí. Equipo SIGEV / EventFlow (2 aprendices). Compartimos el **SRS** como insumo; la metodología, el plan, el diagrama y la matriz de esta carpeta son individuales y distintos de los de mi compañera.

## 2. Qué reutilicé

| Artefacto | Origen | ¿Solo o en equipo? |
|---|---|---|
| SRS (RF1–RF13, RNF-01–RNF-10, HU-01–HU-12) | Documento del equipo, evidencia GA1-37371-AA2-EV01 (octubre de 2026) | En equipo |
| Lista de módulos y actores de SIGEV | SRS del equipo, sección de alcance | En equipo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Diagrama de casos de uso | El diagrama del SRS no tenía «include» ni «extend»; el mío tiene 5 «include» y 4 «extend», cada uno justificado (C4) | (pegar enlace) |
| 2 | Diagrama de casos de uso | Quité «Sistema / Motor de aforo» como actor (el sistema no es actor de sí mismo) y agregué «Servicio de mensajería» como actor secundario externo (C4) | (pegar enlace) |
| 3 | Diagrama de casos de uso | Separé las funciones que el SRS juntaba (por ejemplo, autenticación y roles) y agregué casos que el SRS tenía como requisito pero no como caso: CU-A04 Bloquear cuenta y CU-A09 Validar estructura del archivo (C3, C4) | (pegar enlace) |
| 4 | Diagrama de casos de uso | Pasé de imagen pegada en Word a `.drawio` editable + `.png` (artefacto f) | (pegar enlace) |

## 4. Qué construí nuevo

- La caracterización y la comparación ponderada de 4 metodologías, con la **selección de XP** justificada.
- El plan de 10 actividades con prácticas XP (juego de planificación, spike, tarjetas CRC), responsable, fecha y entregable.
- La matriz RF → CU con 100 % de cobertura y la separación entre RF y RNF.

## 5. Artefactos entregados

- [x] Caracterización: [01-caracterizacion-metodologia.md](01-caracterizacion-metodologia.md) (1.1)
- [x] Comparación y selección de la metodología: [01-caracterizacion-metodologia.md](01-caracterizacion-metodologia.md) (1.2 y 1.3)
- [x] Plan de actividades y cronograma: [02-plan-iteraciones-analisis.md](02-plan-iteraciones-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [diagrama-casos-uso.drawio](diagrama-casos-uso.drawio)
- [x] Diagrama de casos de uso (imagen): [diagrama-casos-uso.png](diagrama-casos-uso.png)
- [x] Justificación de relaciones: [03-casos-uso-relaciones.md](03-casos-uso-relaciones.md)
- [x] Matriz RF → CU: [04-matriz-rf-cu.md](04-matriz-rf-cu.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo (el SRS) está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 me harán 3 preguntas orales y que, si respondo bien menos de 2, el producto queda con tope de 50.

Firma: TU_USUARIO_GITHUB · 26/11/2026

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Claude (Anthropic) | Para generar el `.drawio` del diagrama y redactar borradores de la caracterización, la comparación de metodologías, el plan y la matriz a partir del SRS | (escribe aquí lo que revisaste tú; por ejemplo: recalculé los puntajes de la comparación, revisé que cada RF tenga caso de uso, comprobé el sentido de cada flecha) |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 días distintos.
- [x] No subí material del instructor ni archivos de otras personas.
- [ ] Hice push y comprobé en GitHub que la carpeta está publicada.
