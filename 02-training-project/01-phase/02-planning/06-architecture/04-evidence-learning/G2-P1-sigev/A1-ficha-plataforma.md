# A1 · Ficha de interpretación y plataforma tecnológica

**Caso:** SIGEV (EventFlow Manager) · **Insumo:** SRS compartido del equipo y mi análisis de G1 (`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigev/`)
**Subconjunto que diseño:** los 13 RF. Mis decisiones propias: arquitectura hexagonal, patrones Comando y Fábrica abstracta, contador de aforo en Redis, despliegue en nube gestionada y llaves UUID.

## Requisitos funcionales (13)

| ID | Requisito | Mi caso de uso (G1) |
|---|---|---|
| RF1 | Registro con consentimiento | CU-A01 |
| RF2 | Autenticación segura (con bloqueo por intentos) | CU-A02, CU-A04 |
| RF3 | Recuperación de contraseña | CU-A03 |
| RF4 | Roles y matriz de permisos | CU-A05 |
| RF5 | Programar eventos y tipos de entrada | CU-A06, CU-A07 |
| RF6 | Entradas con QR dinámico | CU-A10, CU-A11 |
| RF7 | Aforo en tiempo real | CU-A15 |
| RF8 | Control de ingreso en puerta | CU-A12, CU-A13 |
| RF9 | Tablero de indicadores | CU-A16 |
| RF10 | Reportes PDF y Excel | CU-A17 |
| RF11 | Carga masiva de asistentes | CU-A08, CU-A09 |
| RF12 | Bitácora inmutable | CU-A18 |
| RF13 | Detección de fraude y alertas | CU-A14 |

## Requisitos no funcionales

| ID | Requisito | Métrica |
|---|---|---|
| RNF-03 | Disponibilidad | ≥ 99,8 % mensual |
| RNF-04 | Tiempo de escaneo | < 1,5 s (percentil 95) |
| RNF-05 | Concurrencia | 500 peticiones por segundo |
| RNF-02 | Cifrado en tránsito | TLS 1.3 |
| RNF-07 | Datos personales | Ley 1581 de 2012 |
| RNF-10 | Operación sin red | 2.000 validaciones en cola |

## Actores y restricciones

- **Actores:** Asistente, Organizador, Validador de acceso, Superadministrador y Servicio de mensajería (externo).
- **Restricciones:**
  - equipo de 2 aprendices;
  - entrega el 28/11/2026;
  - presupuesto bajo: se prefieren servicios gestionados con capa gratuita o de bajo costo y software libre;
  - Ley 1581 de 2012.

## Plataforma

| Elemento | Decisión | Justificación (condiciones del caso) |
|---|---|---|
| **Lenguaje orientado a objetos** | **Java 21 + Spring Boot 3** | (1) Interfaces y tipado fuerte, necesarios para los puertos de la arquitectura hexagonal y para los patrones Comando y Fábrica abstracta. (2) Es el lenguaje que más practicó el equipo en la formación. (3) Tiene librerías maduras para generar PDF y Excel, que alimentan la Fábrica abstracta de reportes (RF10). (4) Spring Security resuelve JWT y bcrypt (RF2, RNF-01). |
| **Base de datos principal** | **Relacional: PostgreSQL 16 gestionado** | (1) El ingreso, el uso único de la entrada y el cupo necesitan transacciones ACID. (2) Las relaciones son fijas (persona → entrada → registro de ingreso). (3) Con la seguridad por filas (RLS) cada asistente ve solo sus datos (RNF-07). (4) El servicio gestionado multi-zona da la disponibilidad (RNF-03) sin que el equipo administre servidores. |
| **Almacén complementario** | **Redis** (clave-valor en memoria) | Solo para el **contador de aforo**: un incremento atómico en memoria tarda menos de 1 ms, frente a bloquear una fila de la base por cada ingreso, lo que ayuda a RNF-04 y RNF-05. La fuente de verdad sigue siendo PostgreSQL. |
| Cliente | TypeScript + React (SPA) y PWA | Cámara e IndexedDB para el modo sin red (RNF-10) |

## Entregables de diseño

A1 (este archivo) · A2 diagrama de clases · A3 patrones · A4 arquitectura hexagonal · A5 vista de componentes · A6 vista de despliegue · A7 matriz · modelo de datos en `../G2-P2-sigev/`.
