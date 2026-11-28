# 1. Plantillas extendidas de los casos críticos

**Casos críticos elegidos:** CU-A05, CU-A08 y CU-A15.
- **CU-A05 (roles):** un error de permisos abre todo el sistema.
- **CU-A08 (carga masiva):** puede crear cientos de registros malos de una sola vez.
- **CU-A15 (aforo):** de él depende la seguridad física del evento.

Las plantillas se redactan como **intención**, sin tecnología.

---

## PL-A05 · Administrar roles y permisos

| Campo | Contenido |
|---|---|
| Identificador y nombre | CU-A05 · Administrar roles y permisos |
| Requisitos que atiende | RF4 |
| Actor primario / secundarios | Superadministrador / — |
| Objetivo del actor | Que cada cuenta tenga exactamente los permisos que su función necesita |
| Precondiciones | 1. El superadministrador inició sesión. 2. Existen los 4 roles base. |
| Disparador | El superadministrador abre «Administración → Roles» |
| Flujo principal | 1. El superadministrador abre la matriz de permisos.<br>2. El sistema muestra los permisos de cada rol.<br>3. El superadministrador busca la cuenta a la que va a asignar un rol.<br>4. El sistema muestra la cuenta y sus roles actuales.<br>5. El superadministrador elige el rol y confirma la asignación.<br>6. El sistema registra la asignación con su fecha y responsable.<br>7. El sistema deja constancia del cambio en la bitácora.<br>8. El sistema confirma y la cuenta adquiere los permisos del rol desde su siguiente acción. |
| Flujos alternos | **1a. Modificar la matriz:** el superadministrador marca o desmarca permisos de un rol y guarda; el caso continúa en el paso 7.<br>**5a. Retirar un rol:** el superadministrador elige retirar en lugar de asignar; el sistema marca la asignación como no vigente y continúa en el paso 7. |
| Excepciones | **5b. Retirar el último superadministrador:** el sistema rechaza el cambio, explica que debe existir al menos uno y el caso termina sin cambios.<br>**5c. La cuenta ya tiene ese rol:** el sistema lo informa y no crea una asignación duplicada. |
| Postcondiciones | La cuenta queda con sus roles actualizados y el cambio queda auditado. |
| Reglas de negocio | RN-A1: siempre existe al menos un superadministrador. RN-A2: una cuenta puede tener varios roles. RN-A3: todo cambio de permisos queda en la bitácora. |
| Pantalla | [P1](mockup-P1-CUA05-roles-permisos.png) |

---

## PL-A08 · Cargar asistentes desde archivo

| Campo | Contenido |
|---|---|
| Identificador y nombre | CU-A08 · Cargar asistentes desde archivo (incluye CU-A09) |
| Requisitos que atiende | RF11 (y RF6 por las entradas que genera) |
| Actor primario / secundarios | Organizador / Servicio de mensajería |
| Objetivo del actor | Inscribir de una vez a muchos asistentes sin digitarlos uno por uno |
| Precondiciones | 1. El organizador inició sesión. 2. El evento está programado y tiene tipos de entrada. |
| Disparador | El organizador elige «Asistentes → Cargar archivo» |
| Flujo principal | 1. El organizador selecciona el evento y adjunta el archivo.<br>2. El sistema valida la estructura del archivo (**incluye CU-A09**).<br>3. El sistema revisa cada fila (documento, correo y tipo de entrada).<br>4. El sistema comprueba que todas las filas son válidas.<br>5. El sistema verifica que haya cupo para todas las filas en sus tipos de entrada.<br>6. El sistema crea las cuentas y entradas de la carga.<br>7. Al mismo tiempo, el sistema registra la carga en la bitácora y envía su entrada a cada asistente.<br>8. El organizador ve el resultado: filas cargadas y filas rechazadas. |
| Flujos alternos | **4a. Hay filas con error y el organizador decide corregir:** el sistema muestra el resumen de errores; el organizador corrige el archivo y el caso vuelve al paso 1.<br>**4b. Hay filas con error y el organizador decide cargar solo las válidas:** el caso continúa en el paso 5 solo con esas filas. |
| Excepciones | **2a. Estructura inválida** (faltan columnas o el formato no es el esperado): el sistema rechaza el archivo, indica las columnas faltantes y el caso termina sin carga.<br>**5a. Cupo insuficiente:** el sistema informa cuántas filas sobran para el cupo disponible y el caso termina sin carga. |
| Postcondiciones | Las personas válidas quedan inscritas con su entrada, la carga queda auditada y cada asistente recibió (o tiene en cola) su entrada. |
| Reglas de negocio | RN-A4: un documento no puede repetirse dentro del mismo evento. RN-A5: la carga es todo o nada respecto al cupo (no se carga a medias). |
| Pantalla | [P2](mockup-P2-CUA08-cargar-asistentes.png) |
| Diagrama de actividades | [AD-A08](actividades-CUA08-cargar-asistentes.png): ramas 2a, 4a, 4b y 5a; bifurcación y unión en el paso 7 |

---

## PL-A15 · Supervisar aforo en vivo

| Campo | Contenido |
|---|---|
| Identificador y nombre | CU-A15 · Supervisar aforo en vivo |
| Requisitos que atiende | RF7, RF9 |
| Actor primario / secundarios | Organizador / — |
| Objetivo del actor | Saber en todo momento cuánta gente hay y actuar antes de que se llene el recinto |
| Precondiciones | 1. El organizador inició sesión. 2. El evento está en curso. |
| Disparador | El organizador abre «Aforo» del evento |
| Flujo principal | 1. El organizador abre el panel de aforo del evento.<br>2. El sistema muestra la ocupación total y por puerta.<br>3. El sistema recibe un nuevo ingreso o salida registrado en una puerta.<br>4. El sistema recalcula el porcentaje de ocupación.<br>5. El sistema comprueba que la ocupación es menor al 80 %.<br>6. El sistema actualiza el panel en pantalla.<br>7. Mientras el organizador siga en el panel, el caso vuelve al paso 3.<br>8. El organizador cierra el panel y el caso termina. |
| Flujos alternos | **5a. La ocupación está entre 80 % y 99 %:** el sistema emite una alerta preventiva; el organizador la revisa y decide la acción; el caso continúa en el paso 6.<br>**5b. La ocupación llega al 100 %:** el sistema bloquea nuevos ingresos y alerta; el organizador revisa y decide; el caso continúa en el paso 6. |
| Excepciones | **3a. Se pierde la conexión del panel:** el sistema muestra «datos desactualizados» con la hora del último dato e intenta reconectarse; no se pueden tomar decisiones con datos viejos. |
| Postcondiciones | El organizador conoció la ocupación real; las alertas emitidas quedaron registradas. |
| Reglas de negocio | RN-A6: al 100 % no entra nadie más hasta que haya salidas. RN-A7: una alerta preventiva se emite una sola vez por cruce del umbral. |
| Pantalla | [P3](mockup-P3-CUA15-aforo-en-vivo.png) |
| Diagrama de actividades | [AD-A15](actividades-CUA15-supervisar-aforo.png): ramas 5a y 5b, y el ciclo del paso 7 |
