# A3 · Patrones de diseño

Los dos patrones aparecen en [`A2-diagrama-clases.png`](A2-diagrama-clases.png). Ninguno es Singleton.

| Patrón | Problema concreto en SIGEV | Por qué este patrón | Clases | Mejora en mantenibilidad |
|---|---|---|---|---|
| **Comando** | Las acciones administrativas (asignar un rol, programar un evento, cargar un lote de asistentes) deben quedar **auditadas** (RF12), poder **deshacerse** si fueron un error (una carga equivocada de 400 personas) y ejecutarse todas igual desde la API de administración. | Cada acción se vuelve un **objeto** con `ejecutar()` y `deshacer()`. Un **invocador** las ejecuta, las guarda en un historial y las registra en la bitácora sin saber qué hace cada una. | `«interface» ComandoAdministrativo` · `AsignarRolComando` · `ProgramarEventoComando` · `CargarLoteComando` · `InvocadorComandos` (agrega el historial) | Una nueva acción (por ejemplo, «Cancelar evento») es **una clase nueva**: no se toca el invocador ni la auditoría. «Deshacer» queda disponible para todas las acciones. Cada comando se prueba por separado. |
| **Fábrica abstracta** | RF10 pide reportes en **PDF y en Excel**. Cada reporte tiene partes que deben ser del **mismo formato**: un encabezado PDF no puede ir con una tabla Excel. | La fábrica crea una **familia** de productos compatibles (encabezado + tabla). `ServicioReportes` pide las partes a la fábrica sin saber el formato. | `«interface» FabricaReporte` · `FabricaReportePdf` · `FabricaReporteExcel` · productos abstractos `EncabezadoReporte` y `TablaReporte` · concretos `EncabezadoPdf`, `TablaPdf`, `EncabezadoExcel`, `TablaExcel` | Agregar un formato nuevo (por ejemplo CSV) es agregar una fábrica y sus 2 productos, sin modificar `ServicioReportes`. Es imposible mezclar partes de dos formatos. |

## Polimorfismo

`InvocadorComandos.ejecutar(c)` llama a `c.ejecutar()` sin saber si es una asignación o una carga (3 implementaciones). `ServicioReportes` llama a `fabrica.crearTabla(...)` sin saber si la tabla es PDF o Excel (2 implementaciones).

## Descartado

**Estrategia para los reportes:** sirve para cambiar *un* algoritmo, pero aquí hay que crear *varias* piezas que deben combinar entre sí. Ese es el problema que resuelve la Fábrica abstracta.
