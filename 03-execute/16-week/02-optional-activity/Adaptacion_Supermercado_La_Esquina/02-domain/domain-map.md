# Mapa de dominio

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


El dominio del sistema gira alrededor de la operación diaria de un supermercado pequeño. Los subdominios principales son:

- **Ventas (POS)**: registro de ventas, selección de productos, cálculo de totales, métodos de pago.
- **Inventario**: catálogo de productos, control de stock, entradas y salidas.
- **Créditos (fiados)**: registro de deudas de clientes y sus pagos.
- **Caja**: cortes de caja, comparación entre dinero físico y registrado.
- **Usuarios y roles**: administrador y cajero, con permisos distintos.
- **Facturación**: generación de tiquetes de venta.

Estos subdominios se relacionan así: una **venta** afecta el **inventario** (descuenta stock), puede generar un **fiado** (si el pago es a crédito) y siempre queda reflejada en el **corte de caja** del día.
