# 4. Matriz requisito funcional → caso de uso

| RF | Requisito | Prioridad | Casos de uso |
|---|---|---|---|
| RF1 | Registro de usuarios y consentimiento de datos | Alta | CU-A01 |
| RF2 | Inicio de sesión seguro | Alta | CU-A02, CU-A04 |
| RF3 | Recuperación de contraseña por correo | Media | CU-A03 |
| RF4 | Roles y matriz de permisos | Alta | CU-A05 |
| RF5 | Creación y parametrización de eventos | Alta | CU-A06, CU-A07 |
| RF6 | Tickets con QR dinámico y envío en PDF | Alta | CU-A10, CU-A11 |
| RF7 | Aforo en tiempo real con alertas al 80 % y 100 % | Alta | CU-A15, CU-A12 |
| RF8 | Validación óptica y verificación fotográfica | Alta | CU-A12, CU-A13 |
| RF9 | Dashboard de indicadores | Media | CU-A16 |
| RF10 | Exportación de reportes PDF y Excel | Media | CU-A17 |
| RF11 | Importación masiva de asistentes por CSV | Baja | CU-A08, CU-A09 |
| RF12 | Bitácora de auditoría inmutable | Alta | CU-A18, CU-A12 (cada ingreso queda registrado) |
| RF13 | Prevención de ingeniería social y alertas | Alta | CU-A14, CU-A04, CU-A11 |

**Cobertura:** 13 de 13 RF = **100 %**. No hay casos de uso sin requisito.

## Requisitos no funcionales (no son casos de uso)

Los RNF describen **cómo de bien** funciona el sistema, no **qué hace**. Por eso no son óvalos: se cumplen dentro de los casos que restringen.

| RNF | Métrica | Casos que restringe |
|---|---|---|
| RNF-01 Contraseñas | Bcrypt factor 12 | CU-A01, CU-A02, CU-A03 |
| RNF-02 Tránsito | TLS 1.3 | Todos |
| RNF-03 Disponibilidad | ≥ 99,8 % | CU-A12, CU-A15 |
| RNF-04 Rendimiento | Escaneo < 1,5 s | CU-A12, CU-A13 |
| RNF-05 Concurrencia | 500 peticiones por segundo | CU-A12 |
| RNF-06 Accesibilidad | WCAG 2.1 AA | CU-A01, CU-A10 |
| RNF-07 Datos personales | Ley 1581 de 2012 | CU-A01, CU-A08 |
| RNF-08 Anti-clonación | QR rotativo de 30 s | CU-A10, CU-A13 |
| RNF-09 Portabilidad | Docker | (infraestructura) |
| RNF-10 Offline | 2.000 validaciones en cola | CU-A12 |
