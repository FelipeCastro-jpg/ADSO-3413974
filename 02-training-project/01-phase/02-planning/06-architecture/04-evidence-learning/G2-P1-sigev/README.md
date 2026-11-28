# README · Guía 2 · Producto 1: artefactos de diseño

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | FelipeCastro-jpg |
| Ficha | 3413974 |
| Caso | SIGEV (EventFlow Manager) |
| SRS / análisis | `../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigev/03-informe-analisis.md` |
| Cuenta de los commits | FelipeCastro-jpg |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS lo elaboró un equipo? | Sí, equipo de 2 aprendices. El SRS es compartido. |
| ¿Qué parte es mía? | Diseño los 13 RF con decisiones propias, distintas de las de mi compañera: arquitectura hexagonal, patrones Comando y Fábrica abstracta, Redis para el aforo, nube gestionada. |
| ¿Hice solo los artefactos? | Sí |
| ¿Otro aprendiz me compartió archivos de esta entrega? | No (solo compartimos el SRS) |

## 3. Qué reutilicé, ajusté e hice nuevo

| Artefacto | Archivo | Origen | Qué ajusté o agregué |
|---|---|---|---|
| A1 | `A1-ficha-plataforma.md` | Stack del SRS (React, Spring Boot, PostgreSQL) | Agregué Redis y la nube gestionada, y justifiqué cada elección con condiciones del caso |
| A2 | `A2-diagrama-clases.drawio` / `.png` | Mi modelo de dominio de G1-P2 | Pasé de conceptos a clases con tipos, visibilidad y métodos; agregué comandos y fábricas (22 clases) |
| A3 | `A3-patrones.md` | nuevo | Comando y Fábrica abstracta |
| A4 | `A4-arquitectura-hexagonal.*` | nuevo | Hexagonal con 7 puertos; tabla de 5 RNF |
| A5 | `A5-vista-componentes.*` | nuevo | 12 componentes y 11 interfaces |
| A6 | `A6-vista-despliegue.*` | nuevo | 8 nodos en nube gestionada |
| A7 | `A7-matriz-trazabilidad.md` | Mi matriz RF → CU de G1-P1 | La extendí hasta clase, tabla y componente |

**Qué reutilicé:** el SRS del equipo y mi modelo de dominio de G1.

**Qué ajusté:** el dominio de G1 no tenía métodos ni tipos; la clase de asociación Asignacion ahora tiene comportamiento (`revocar()`).

**Qué hice nuevo:** los patrones, la arquitectura, los componentes y el despliegue.

## 4. Autoverificación de mínimos

- [x] A1: 13 RF, 6 RNF, plataforma justificada
- [x] A2: 22 clases con tipos y métodos; multiplicidades; composición (Evento ◆ TipoEntrada) y agregación (InvocadorComandos ◇ ComandoAdministrativo); interfaces con ≥ 2 implementaciones (ComandoAdministrativo con 3, FabricaReporte con 2); herencia (EncabezadoReporte y TablaReporte)
- [x] A3: Comando y Fábrica abstracta
- [x] A4: diagrama y tabla de 5 RNF
- [x] A5: 12 componentes con interfaces
- [x] A6: 8 nodos con protocolos
- [x] A7: matriz 13/13 RF y 22/22 clases
- [x] `.drawio` + `.png` de cada diagrama

## 5. Historial de commits

| Día | Qué avancé |
|---|---|
| (día 1) |  Jueves 26/11/2026 | Add files via upload (primeros diagramas de diseño y modelo de datos) |
| (día 2) | Viernes 27/11/2026 | Add files via upload (carpetas completas G2-P1 y G2-P2) |

## 6. Uso de IA

| Herramienta | Para qué | Qué verifiqué o cambié |
|---|---|---|
| Claude (Anthropic) | Para generar los `.drawio` y borradores de las tablas a partir de las decisiones de diseño | (Claude generó los diagramas y los textos. Yo revisé dónde están los patrones Comando y Fábrica abstracta en el diagrama de clases, por qué la arquitectura es hexagonal y para qué sirve Redis en el aforo.) |

## 7. Enlaces

- Producto 2: `../G2-P2-sigev/`

| Artefacto | Decisión principal |
|---|---|
| [A1](A1-ficha-plataforma.md) | PostgreSQL para la verdad, Redis solo para contar el aforo |
| [A2](A2-diagrama-clases.png) | Las acciones administrativas son objetos comando |
| [A3](A3-patrones.md) | Comando (auditar y deshacer) y Fábrica abstracta (PDF y Excel) |
| [A4](A4-A5-A6-arquitectura-componentes-despliegue.md) | Hexagonal: el dominio no depende de nada |
| [A5](A5-vista-componentes.png) | Los adaptadores implementan los puertos |
| [A6](A6-vista-despliegue.png) | Nube gestionada con autoescalado |
| [A7](A7-matriz-trazabilidad.md) | 100 % de trazabilidad |

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo reutilizado está en la sección 3 y que puedo explicar cada uno en la verificación oral.

Usuario de GitHub: FelipeCastro-jpg · Fecha: 27/11/2026
