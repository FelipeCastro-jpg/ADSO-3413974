# Arquitectura — Vista general

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


## Enfoque

El sistema "La Esquina" se implementa como una **aplicación monolítica de escritorio/local**, no como microservicios. Esta decisión responde directamente a los requerimientos no funcionales del SRS: debe funcionar sin internet, ejecutarse en equipos económicos y ser simple de mantener por un negocio pequeño.

## Componentes principales

- **Interfaz de usuario (UI)**: pantallas de venta (POS), gestión de productos, reportes y usuarios.
- **Lógica de negocio**: reglas de ventas, control de stock, cálculo de cortes de caja, manejo de fiados.
- **Capa de datos**: base de datos local donde se guardan productos, ventas, clientes y usuarios.
- **Módulo de reportes**: generación de cortes de caja y tiquetes de venta.

## Diagrama de componentes

Ver [08-uml/diagrams](../08-uml/diagrams/) para el diagrama de componentes y despliegue.
