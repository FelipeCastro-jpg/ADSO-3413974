# Análisis y propuestas de mejora – Mockup de Gestión de Horarios SENA

## 1. Introducción

Se realizó una revisión general del mockup de Gestión de Horarios desde el punto de vista de un usuario. También se tomó como referencia la página del SENA relacionada con el Sistema Integrado de Gestión y Autocontrol (SIGA).

El objetivo de este análisis no es decir que el sistema está mal, sino identificar oportunidades de mejora que podrían hacer que la página sea más sencilla, clara y cómoda de utilizar.

Las propuestas se expresan mediante historias de usuario y se enfocan principalmente en la navegación, consulta de horarios, organización de la información y reducción de pasos que podrían resultar innecesarios.

---

# 2. Rol: Aprendiz

El aprendiz necesita principalmente consultar su información académica de forma rápida, especialmente los horarios, ambientes y posibles cambios.

## HU-01 – Consultar el horario

**Como aprendiz**, quiero consultar mi horario de manera sencilla, **para saber rápidamente qué clase tengo, a qué hora y en qué ambiente**.

**Qué cambiaría:**  
Haría que la opción de horario fuera fácil de encontrar y mostraría primero el día, hora, ambiente e instructor.

**Motivo:**  
Son los datos que normalmente necesita consultar el aprendiz con mayor frecuencia.

## HU-02 – Recibir avisos de cambios

**Como aprendiz**, quiero recibir una notificación cuando se modifique mi horario, **para enterarme de los cambios antes de asistir a clase**.

**Qué agregaría:**  
Una sección de notificaciones donde aparezcan cambios de horario, cancelaciones o modificaciones importantes.

## HU-03 – Ver los detalles de una clase

**Como aprendiz**, quiero seleccionar una clase de mi horario, **para consultar sus datos completos**.

**Qué cambiaría:**  
Al seleccionar una clase mostraría instructor, ambiente, ficha, programa, fecha y duración.

## HU-04 – Filtrar información

**Como aprendiz**, quiero poder filtrar mi horario por fecha o programa, **para encontrar más rápido la información que necesito**.

**Qué agregaría:**  
Filtros sencillos, evitando que el usuario tenga que revisar todo el horario.

## HU-05 – Consultar desde celular

**Como aprendiz**, quiero consultar mi horario desde el celular, **para poder revisarlo cuando no tenga un computador disponible**.

**Qué cambiaría:**  
La versión móvil debería mostrar primero la información principal y evitar elementos que ocupen demasiado espacio.

---

# 3. Rol: Instructor

El instructor necesita consultar sus clases y grupos y conocer rápidamente cualquier modificación en la programación.

## HU-06 – Consultar las clases del día

**Como instructor**, quiero visualizar mis clases organizadas por día y hora, **para saber qué actividades debo realizar**.

**Qué cambiaría:**  
Utilizaría una vista tipo calendario o una lista ordenada por hora.

## HU-07 – Consultar el grupo

**Como instructor**, quiero acceder a la información del grupo desde mi horario, **para consultar fácilmente la ficha y los aprendices asignados**.

**Qué agregaría:**  
Un botón como “Ver grupo” dentro de la información de cada clase.

## HU-08 – Recibir cambios

**Como instructor**, quiero recibir un aviso cuando cambie una clase, **para evitar confusiones con los aprendices**.

**Qué agregaría:**  
Notificaciones para cambios de ambiente, horario o cancelaciones.

## HU-09 – Buscar una clase específica

**Como instructor**, quiero filtrar mis horarios, **para encontrar rápidamente una clase determinada**.

**Qué cambiaría:**  
Permitir filtros por fecha, ficha, ambiente o programa.

## HU-10 – Consultar ambientes

**Como instructor**, quiero consultar la disponibilidad de los ambientes, **para conocer los espacios que puedo utilizar**.

**Qué agregaría:**  
Una consulta sencilla de ambientes disponibles.

---

# 4. Rol: Coordinador Académico

El coordinador necesita una visión más amplia de la programación y herramientas para organizar los horarios.

## HU-11 – Consultar programación general

**Como coordinador académico**, quiero visualizar los horarios de los diferentes grupos, **para tener una visión general de la programación**.

**Qué cambiaría:**  
Utilizar filtros por programa, ficha, instructor, ambiente y fecha.

## HU-12 – Detectar cruces de horarios

**Como coordinador académico**, quiero recibir una alerta cuando exista un conflicto de horario, **para poder solucionarlo antes de confirmar la programación**.

**Qué agregaría:**  
Un mensaje de advertencia cuando dos actividades tengan el mismo ambiente u horario incompatible.

## HU-13 – Modificar un horario

**Como coordinador académico**, quiero modificar un horario fácilmente, **para solucionar cambios o inconvenientes en la programación**.

**Qué cambiaría:**  
Haría más visible la opción de editar y mostraría una confirmación antes de guardar.

## HU-14 – Consultar ambientes disponibles

**Como coordinador académico**, quiero consultar los ambientes disponibles por fecha y hora, **para asignarlos correctamente**.

**Qué agregaría:**  
Filtros de disponibilidad.

## HU-15 – Generar reportes

**Como coordinador académico**, quiero generar un reporte de la programación, **para poder revisar o compartir la información**.

**Qué agregaría:**  
Una opción para descargar o generar un reporte.

---

# 5. Rol: Director de Centro

Para este usuario las mejoras pueden enfocarse en facilitar la consulta general sin agregar demasiadas funciones.

## HU-16 – Ver la programación general

**Como director de centro**, quiero consultar la programación académica, **para conocer cómo están distribuidos los horarios del centro**.

**Qué cambiaría:**  
Mostrar un resumen de programas, fichas, instructores y ambientes.

## HU-17 – Consultar uso de ambientes

**Como director de centro**, quiero conocer la disponibilidad y utilización de los ambientes, **para tener una visión general de los espacios**.

**Qué agregaría:**  
Una consulta sencilla de ambientes ocupados y disponibles.

## HU-18 – Consultar información resumida

**Como director de centro**, quiero visualizar información resumida de la programación, **para conocer rápidamente el estado general**.

**Qué agregaría:**  
Indicadores sencillos, como grupos activos, ambientes utilizados e instructores programados.

---

# 6. Rol: Administrador / Soporte

Las funciones de soporte deberían facilitar la búsqueda de usuarios y la atención de problemas.

## HU-19 – Buscar usuarios

**Como administrador de soporte**, quiero buscar un usuario rápidamente, **para poder revisar su información cuando tenga un problema**.

**Qué agregaría:**  
Una barra de búsqueda por nombre, identificación o correo.

## HU-20 – Consultar solicitudes

**Como administrador de soporte**, quiero visualizar los problemas reportados por los usuarios, **para atenderlos de manera organizada**.

**Qué agregaría:**  
Una sección de solicitudes pendientes, atendidas y en proceso.

## HU-21 – Consultar estado de cuenta

**Como administrador de soporte**, quiero consultar el estado de una cuenta, **para identificar rápidamente problemas de acceso**.

**Qué cambiaría:**  
Mostrar la información principal de la cuenta en una sola pantalla.

---

# 7. Parametrización

La parametrización puede mantenerse, pero algunas opciones podrían organizarse mejor.

## HU-22 – Organizar configuraciones

**Como administrador**, quiero encontrar las configuraciones agrupadas por categorías, **para poder modificarlas con mayor facilidad**.

**Qué cambiaría:**  
Agrupar las opciones relacionadas en lugar de mostrarlas todas juntas.

## HU-23 – Confirmar cambios importantes

**Como administrador**, quiero recibir una confirmación antes de guardar cambios importantes, **para evitar modificaciones accidentales**.

**Qué agregaría:**  
Un mensaje de confirmación antes de guardar, eliminar o modificar información importante.

## HU-24 – Buscar configuraciones

**Como administrador**, quiero buscar una configuración específica, **para no tener que revisar todas las opciones manualmente**.

**Qué agregaría:**  
Un buscador o filtros dentro del apartado de parametrización.

---

# 8. Partes o pantallas que podrían simplificarse

Durante una revisión de este tipo también es importante preguntarse si todas las pantallas necesitan existir como pantallas independientes.

No se propone eliminar funciones importantes. La idea sería reducir pasos cuando dos pantallas cumplen prácticamente la misma función.

## 8.1 Consultas repetidas

Si existen varias pantallas que muestran información similar del horario, se podrían unificar.

**Propuesta:**  
Utilizar una sola pantalla de consulta con filtros.

**Beneficio:**  
El usuario no tendría que entrar en diferentes apartados para consultar información relacionada.

## 8.2 Pantallas que solamente muestran instrucciones

Si una pantalla solamente explica qué debe hacer el usuario y luego lo envía a otra pantalla, podría reducirse la cantidad de pasos.

**Propuesta:**  
Colocar una explicación corta directamente en la pantalla donde se realiza la acción.

## 8.3 Confirmaciones innecesarias

Las confirmaciones son útiles para acciones importantes, pero pueden resultar molestas si aparecen constantemente.

**Propuesta:**  
Usarlas principalmente para eliminar, guardar o modificar información importante.

## 8.4 Información duplicada

Si dos pantallas muestran los mismos datos, pero con pequeñas diferencias, podría utilizarse una sola pantalla con filtros.

**Propuesta:**  
Centralizar la consulta y permitir que el usuario seleccione qué información quiere visualizar.

## 8.5 Opciones administrativas poco utilizadas

Algunas opciones pueden ser necesarias para la administración, pero no necesariamente necesitan ocupar una pantalla independiente.

**Propuesta:**  
Agrupar configuraciones relacionadas dentro de un mismo apartado.

---

# 9. Qué mantendría, qué cambiaría y qué simplificaría

## Mantendría

- La separación de funciones según el tipo de usuario.
- La consulta de horarios.
- Las opciones necesarias para administrar la programación.
- Las funciones administrativas importantes.
- La información relacionada con ambientes, grupos e instructores.

## Cambiaría

- La forma de encontrar algunas opciones.
- La presentación de la información del horario.
- La visibilidad de filtros y búsquedas.
- La forma de mostrar cambios o notificaciones.
- La adaptación de algunas vistas para celulares.

## Simplificaría

- Pantallas que muestran información muy parecida.
- Pasos innecesarios para llegar a una consulta.
- Confirmaciones para acciones que no son importantes.
- Menús con demasiadas opciones juntas.
- Información repetida.

## No eliminaría sin revisar

Las funciones administrativas o de configuración no deberían eliminarse solamente porque un usuario común no las utilice. Algunas pueden ser necesarias para otros roles.

---

# 10. Mejoras generales

| Mejora | Para qué serviría |
|---|---|
| Buscador | Encontrar información rápidamente |
| Filtros | Reducir la información mostrada |
| Notificaciones | Avisar cambios importantes |
| Calendario | Visualizar mejor los horarios |
| Confirmaciones | Evitar modificaciones accidentales |
| Vista móvil | Facilitar el uso desde celular |
| Reportes | Consultar o compartir información |
| Ayuda | Orientar al usuario |
| Botón volver | Facilitar la navegación |
| Perfil | Consultar información personal |

---

# 11. Priorización

## Prioridad alta

- Mejorar la consulta de horarios.
- Agregar filtros.
- Notificar cambios.
- Detectar conflictos de horarios.
- Facilitar el uso desde dispositivos móviles.

## Prioridad media

- Generar reportes.
- Mejorar la consulta de ambientes.
- Agregar buscadores.
- Organizar mejor las configuraciones.

## Prioridad baja

- Indicadores generales.
- Ayudas adicionales.
- Cambios visuales menores.

---

# 12. Ejemplo de una mejora completa

Una de las mejoras más importantes sería la consulta del horario.

### Situación

El aprendiz necesita consultar constantemente su horario y conocer rápidamente el día, hora, ambiente e instructor.

### Historia de usuario

**Como aprendiz**, quiero consultar mi horario de forma rápida y organizada, **para saber dónde y cuándo debo asistir a mis clases**.

### Propuesta

Crear una pantalla principal de horario con:

- Día.
- Fecha.
- Hora.
- Programa.
- Ficha.
- Instructor.
- Ambiente.
- Estado de la clase.
- Filtros.

### Resultado esperado

El usuario podría encontrar la información que necesita sin tener que recorrer varias pantallas.

---

# 13. Conclusión

Después de revisar el mockup desde el punto de vista de un usuario, considero que no es necesario cambiar completamente el sistema. La mayoría de las propuestas son pequeños ajustes que pueden mejorar la experiencia sin modificar la idea principal del proyecto.

Las principales mejoras serían facilitar la consulta de horarios, agregar filtros y notificaciones, organizar mejor la información y reducir algunos pasos innecesarios.

También sería conveniente revisar si existen pantallas que realizan funciones muy similares. En esos casos, algunas podrían unirse mediante filtros o pestañas en lugar de mantener varias pantallas separadas.

La intención de estas propuestas es que cada usuario pueda encontrar la información que necesita de una manera más rápida, clara y sencilla, manteniendo las funciones importantes para cada rol.
