# 4. Matriz de trazabilidad (Anexo C)

| Requisito | Caso de uso | Diagrama de actividades | Plantilla | Clase de dominio | Entidad del MER | Pantalla |
|---|---|---|---|---|---|---|
| RF1 Registro y consentimiento | CU-A01 | – | – | Persona, CuentaUsuario | PERSONA, CUENTA | – |
| RF2 Autenticación | CU-A02, CU-A04 | – | – | CuentaUsuario (intentosFallidos) | CUENTA | – |
| RF3 Recuperar contraseña | CU-A03 | – | – | CuentaUsuario | CUENTA | – |
| RF4 Roles y permisos | **CU-A05** | – | **PL-A05** | Rol, Permiso, Asignación | ROL, ASIGNACIÓN | **P1** |
| RF5 Programar eventos | CU-A06, CU-A07 | – | – | Evento, Recinto, TipoEntrada | EVENTO, RECINTO, TIPO_ENTRADA | – |
| RF6 Entradas con QR | CU-A10, CU-A11 | AD-A08 (paso 7) | PL-A08 (paso 7) | Entrada, Notificación | ENTRADA | P2 |
| RF7 Aforo en tiempo real | **CU-A15**, CU-A12 | **AD-A15** | **PL-A15** | Evento (aforoMáximo), RegistroIngreso | EVENTO, REGISTRO_INGRESO | **P3** |
| RF8 Validación en puerta | CU-A12, CU-A13 | – | – | RegistroIngreso, Entrada, Puerta | REGISTRO_INGRESO, PUERTA | – |
| RF9 Indicadores | CU-A16 | AD-A15 | PL-A15 | Evento, RegistroIngreso | EVENTO, REGISTRO_INGRESO | P3 |
| RF10 Reportes | CU-A17 | – | – | RegistroIngreso, Entrada | REGISTRO_INGRESO, ENTRADA | – |
| RF11 Carga masiva | **CU-A08**, CU-A09 | **AD-A08** | **PL-A08** | LoteCarga, LíneaCarga, Persona | PERSONA, ENTRADA | **P2** |
| RF12 Bitácora | CU-A18 | AD-A08 (registro en bitácora) | PL-A05 (paso 7) | EventoAuditoría | REGISTRO_INGRESO (cada ingreso) | – |
| RF13 Anti-fraude | CU-A14, CU-A04 | – | – | RegistroIngreso (motivo), Notificación | REGISTRO_INGRESO | – |

**Cobertura:** caso de uso 13/13 · clase 13/13 · entidad 13/13 (100 %) · los 3 casos críticos llegan a plantilla, diagrama de actividades y pantalla.
