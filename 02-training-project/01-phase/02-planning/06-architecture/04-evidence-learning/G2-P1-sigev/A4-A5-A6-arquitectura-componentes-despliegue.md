# A4 · Arquitectura · A5 · Componentes · A6 · Despliegue

## A4 · Arquitectura hexagonal (puertos y adaptadores)

Diagrama: [`A4-arquitectura-hexagonal.png`](A4-arquitectura-hexagonal.png) · fuente: [`.drawio`](A4-arquitectura-hexagonal.drawio)

**Estilo:** hexagonal.
- En el centro está el **núcleo de dominio** (las reglas del aforo, del uso único de la entrada y del bloqueo de cuentas).
- Alrededor está la **capa de aplicación** (casos de uso, comandos, reportes).
- Todo lo externo entra o sale por **puertos** (interfaces) implementados por **adaptadores**: REST, WebSocket, JPA, Redis, correo y bitácora.
- **Las dependencias apuntan hacia el núcleo.** El dominio no conoce Spring ni PostgreSQL.

**Comunicación:**
- REST/JSON sobre HTTPS (síncrona) para las operaciones.
- WSS para empujar el aforo en vivo del servidor al cliente.
- Llamadas en proceso entre adaptadores, puertos y núcleo.

| RNF | Decisión | Alternativa descartada | Razón |
|---|---|---|---|
| RNF-04 escaneo < 1,5 s | Contador de aforo en **Redis** (incremento atómico en memoria) detrás de `PuertoContadorAforo` | Actualizar la fila del evento en PostgreSQL en cada ingreso | Con 4 puertas simultáneas se forma una cola de bloqueos sobre la misma fila |
| RNF-05 500 peticiones/s | API sin estado y **autoescalado de 2 a 4 réplicas** | Servidor fijo | No absorbe el pico de la apertura de puertas |
| RNF-03 99,8 % | Réplicas en 2 zonas y PostgreSQL multi-zona | Un servidor propio en el SENA | Un corte de energía tumba el evento |
| RNF-07 datos personales | Seguridad por filas (RLS) en PostgreSQL más adaptadores que nunca exponen el documento completo | Filtrar solo en la interfaz | Se puede saltar llamando a la API directamente |
| RNF-10 sin red | PWA servida por CDN con cola local que sincroniza por `IComandos` | Detener el ingreso | Para el evento por una falla de red |

**Alternativa de estilo descartada:** capas clásicas (presentación → negocio → datos). En ese estilo la lógica de negocio termina dependiendo del framework de persistencia. En SIGEV hay **tres** salidas distintas que pueden cambiar de proveedor (base de datos, contador y mensajería), y con puertos se cambia un adaptador sin tocar las reglas del aforo.

## A5 · Vista de componentes

Diagrama: [`A5-vista-componentes.png`](A5-vista-componentes.png) · fuente: [`.drawio`](A5-vista-componentes.drawio)

| Componente | Provee | Requiere | Clases (A2) | RF |
|---|---|---|---|---|
| Clientes (SPA + PWA) | – | API /api/v1, Canal WSS, API /admin | – | Todos |
| Adaptador REST | API /api/v1 | ICasosDeUso, IReportes | controladores | RF1–RF3, RF6, RF8–RF10 |
| Adaptador WebSocket | Canal WSS | ICasosDeUso | – | RF7, RF9 |
| Adaptador REST admin | API /admin | IComandos, IReportes | – | RF4, RF5, RF11 |
| Casos de uso | ICasosDeUso | RepositorioDatos, PuertoNotificacion, PuertoContadorAforo, PuertoAuditoria, IModeloDominio | servicios de control de ingreso y aforo | RF6–RF8, RF13 |
| Comandos administrativos | IComandos | RepositorioDatos, PuertoAuditoria, IModeloDominio | `InvocadorComandos`, `ComandoAdministrativo`, 3 comandos | RF4, RF5, RF11, RF12 |
| Reportes | IReportes | RepositorioDatos, IModeloDominio | `ServicioReportes`, `FabricaReporte` y su familia | RF9, RF10 |
| Núcleo de dominio | IModeloDominio | (nada) | `Evento`, `TipoEntrada`, `Entrada`, `RegistroIngreso`, `CuentaUsuario`, `Rol`, `Asignacion` | RF2, RF5–RF8 |
| Adaptador JPA | RepositorioDatos | PostgreSQL | – | Persistencia |
| Adaptador mensajería | PuertoNotificacion | proveedor de correo y SMS | – | RF3, RF6, RF13 |
| Adaptador Redis | PuertoContadorAforo | Redis | – | RF7 |
| Adaptador bitácora | PuertoAuditoria | tabla de solo inserción | – | RF12 |

## A6 · Vista de despliegue

Diagrama: [`A6-vista-despliegue.png`](A6-vista-despliegue.png) · fuente: [`.drawio`](A6-vista-despliegue.drawio)

| Nodo | Artefactos | Conexión | RNF |
|---|---|---|---|
| Dispositivo cliente | `sigev-web`, `sigev-puerta` (PWA) | → Balanceador HTTPS/WSS 443; → CDN HTTPS 443 | RNF-10 |
| CDN / hosting estático | build de la SPA y la PWA | (sirve archivos) | RNF-10, RNF-04 (carga rápida) |
| Balanceador gestionado | certificado TLS | → Contenedores HTTP 8080 (red privada) | RNF-02 |
| Servicio de contenedores | `sigev-api:1.0` × 2–4 réplicas | → PostgreSQL TLS 5432; → Redis TLS 6380; → Mensajería HTTPS 443 | RNF-03, RNF-05 |
| PostgreSQL gestionado multi-zona | esquema `sigev` | → Almacenamiento de objetos (copia diaria) | RNF-03 |
| Redis gestionado | contador de aforo | – | RNF-04 |
| Almacenamiento de objetos | respaldos y fotos cifradas | – | Disponibilidad y confidencialidad |
| Proveedor de correo y SMS | API de envío | – | RF6, RF13 |
