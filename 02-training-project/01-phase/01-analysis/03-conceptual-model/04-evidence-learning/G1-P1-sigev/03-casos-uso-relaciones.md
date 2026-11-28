# 3. Casos de uso de SIGEV y justificación de relaciones

Fuente editable: [`diagrama-casos-uso.drawio`](diagrama-casos-uso.drawio) · Imagen: [`diagrama-casos-uso.png`](diagrama-casos-uso.png)

## Actores

| Actor | Tipo | Rol en el sistema |
|---|---|---|
| Usuario del sistema | Primario abstracto | Generaliza a Asistente, Organizador, Validador y Superadministrador; todos se autentican igual |
| Asistente | Primario | Crea su cuenta y genera su entrada |
| Organizador | Primario | Programa eventos, carga asistentes, supervisa el aforo y consulta indicadores |
| Validador de acceso | Primario | Controla el ingreso en la puerta |
| Superadministrador | Primario | Administra roles y permisos y audita la bitácora |
| Servicio de mensajería | Secundario («sistema externo») | Entrega correos y SMS; no inicia casos |

## Catálogo (18 casos de uso)

| ID | Caso de uso | Iniciador | RF |
|---|---|---|---|
| CU-A01 | Crear cuenta de asistente | Asistente | RF1 |
| CU-A02 | Autenticarse | Usuario del sistema | RF2 |
| CU-A03 | Restablecer contraseña | Extiende CU-A02 | RF3 |
| CU-A04 | Bloquear cuenta por intentos fallidos | Extiende CU-A02 | RF2, RF13 |
| CU-A05 | Administrar roles y permisos | Superadministrador | RF4 |
| CU-A06 | Programar evento | Organizador | RF5 |
| CU-A07 | Configurar tipos de entrada | Incluido por CU-A06 | RF5 |
| CU-A08 | Cargar asistentes desde archivo | Organizador | RF11 |
| CU-A09 | Validar estructura del archivo | Incluido por CU-A08 | RF11 |
| CU-A10 | Generar entrada con código QR | Asistente | RF6 |
| CU-A11 | Notificar al titular | Incluido por CU-A10 y CU-A14 | RF6, RF13 |
| CU-A12 | Controlar ingreso en puerta | Validador de acceso | RF8, RF7, RF12 |
| CU-A13 | Verificar código QR | Incluido por CU-A12 | RF8 |
| CU-A14 | Reportar posible fraude | Extiende CU-A12 | RF13 |
| CU-A15 | Supervisar aforo en vivo | Organizador | RF7 |
| CU-A16 | Consultar tablero de indicadores | Organizador | RF9 |
| CU-A17 | Generar reporte de asistencia | Extiende CU-A16 | RF10 |
| CU-A18 | Auditar bitácora | Superadministrador | RF12 |

**Agrupación de operaciones:** «Programar evento» reúne crear, modificar y cancelar, y «Administrar roles y permisos» reúne asignar y retirar, porque tienen el mismo actor y las mismas reglas.

## Justificación de relaciones

| # | Relación | Tipo | Justificación |
|---|---|---|---|
| 1 | CU-A06 Programar evento → CU-A07 Configurar tipos de entrada | «include» | Un evento **siempre** se programa con al menos un tipo de entrada y su aforo; sin eso no se puede vender. |
| 2 | CU-A08 Cargar asistentes → CU-A09 Validar estructura del archivo | «include» | **Toda** carga pasa por la validación de columnas y formatos antes de crear registros (RF11 exige validación). |
| 3 | CU-A10 Generar entrada → CU-A11 Notificar al titular | «include» | Cada entrada generada **siempre** se envía al correo del asistente (RF6). |
| 4 | CU-A14 Reportar posible fraude → CU-A11 Notificar al titular | «include» | Todo reporte de fraude **siempre** avisa al titular legítimo (RF13). CU-A11 se reutiliza en dos casos. |
| 5 | CU-A12 Controlar ingreso → CU-A13 Verificar código QR | «include» | **Todo** control de ingreso verifica el código; es el núcleo del caso. |
| 6 | CU-A03 Restablecer contraseña → CU-A02 Autenticarse | «extend» | Solo **si** el usuario olvidó la contraseña. Punto de extensión: «Olvidé mi contraseña». |
| 7 | CU-A04 Bloquear cuenta → CU-A02 Autenticarse | «extend» | Solo **si** hay 5 intentos fallidos seguidos. Punto de extensión: «Credenciales rechazadas». |
| 8 | CU-A14 Reportar posible fraude → CU-A12 Controlar ingreso | «extend» | Solo **si** el código ya se usó o se reescaneó en otra puerta. Punto de extensión: «Ingreso denegado». |
| 9 | CU-A17 Generar reporte → CU-A16 Consultar tablero | «extend» | Solo **si** el organizador decide exportar lo que está viendo. Punto de extensión: «Exportar». |
| 10 | Asistente, Organizador, Validador y Superadministrador → Usuario del sistema | Generalización | Evita 4 asociaciones repetidas con CU-A02, porque todos se autentican igual. |

**Reglas verificadas:** 18 casos con verbo + objeto; actores fuera de la frontera; sin ciclos; todo caso tiene un iniciador (actor primario o caso base); el servicio de mensajería solo recibe.
