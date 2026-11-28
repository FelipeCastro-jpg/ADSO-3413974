# A7 · Matriz análisis → diseño

Las tablas corresponden al modelo lógico de `../G2-P2-sigev/` (esquema `sigev`).

| RF | Clases | Tablas | Componentes | Patrón / decisión |
|---|---|---|---|---|
| RF1 | CuentaUsuario | personas, cuentas, consentimientos | Casos de uso, Adaptador REST | RLS sobre personas |
| RF2 | CuentaUsuario (intentosFallidos, bloquear) | cuentas | Casos de uso | Bloqueo tras 5 intentos |
| RF3 | CuentaUsuario | cuentas | Casos de uso, Adaptador mensajería | Puerto de notificación |
| RF4 | Rol, Asignacion, AsignarRolComando | roles, asignaciones | Comandos administrativos | **Comando** |
| RF5 | Evento, TipoEntrada, ProgramarEventoComando | eventos, tipos_entrada, recintos, puertas | Comandos administrativos | **Comando**; composición Evento ◆ TipoEntrada |
| RF6 | Entrada, TipoEntrada | entradas | Casos de uso, Adaptador mensajería | – |
| RF7 | Evento (ocupación), RegistroIngreso | eventos, registros_ingreso | Casos de uso, Adaptador Redis, Adaptador WebSocket | Contador en Redis |
| RF8 | RegistroIngreso, Entrada | registros_ingreso, entradas, puertas | Casos de uso | – |
| RF9 | Evento, RegistroIngreso | eventos, registros_ingreso | Reportes, Adaptador WebSocket | – |
| RF10 | ServicioReportes, FabricaReporte, FabricaReportePdf, FabricaReporteExcel, Encabezado*/Tabla* | registros_ingreso, entradas | Reportes | **Fábrica abstracta** |
| RF11 | CargarLoteComando | lotes_carga, personas, entradas | Comandos administrativos | **Comando** (deshacer la carga) |
| RF12 | InvocadorComandos | bitacora | Adaptador bitácora | Solo inserción |
| RF13 | RegistroIngreso (motivo), CuentaUsuario | registros_ingreso | Casos de uso, Adaptador mensajería | – |

**Cobertura:** 13/13 RF llegan a clase, tabla y componente.

## Clase → RF (ninguna clase queda sin requisito)

Rol (RF4) · CuentaUsuario (RF1–RF3, RF13) · Asignacion (RF4) · Evento (RF5, RF7, RF9) · TipoEntrada (RF5, RF6) · Entrada (RF6, RF8) · RegistroIngreso (RF7–RF9, RF13) · InvocadorComandos (RF12) · ComandoAdministrativo, AsignarRolComando (RF4) · ProgramarEventoComando (RF5) · CargarLoteComando (RF11) · ServicioReportes, FabricaReporte, FabricaReportePdf, FabricaReporteExcel, EncabezadoReporte, TablaReporte, EncabezadoPdf, TablaPdf, EncabezadoExcel, TablaExcel (RF10) → **22/22**.
