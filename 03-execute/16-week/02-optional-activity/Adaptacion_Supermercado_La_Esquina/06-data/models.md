# Modelo de datos

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


## Entidades y relaciones

- **Producto** (1) → (N) **DetalleVenta**
- **Venta** (1) → (N) **DetalleVenta**
- **Venta** (1) → (0..1) **Fiado**
- **Cliente** (1) → (N) **Fiado**
- **Usuario** (1) → (N) **Venta**
- **CorteCaja** (1) → (N) **Venta** (ventas del día)

## Atributos principales

- **Producto**: id, nombre, código, precio_compra, precio_venta, stock, stock_minimo.
- **Venta**: id, fecha, total, metodo_pago, usuario_id.
- **DetalleVenta**: id, venta_id, producto_id, cantidad, precio_unitario, subtotal.
- **Cliente**: id, nombre, identificación, teléfono.
- **Fiado**: id, cliente_id, venta_id, monto, estado, fecha.
- **Usuario**: id, nombre, usuario, contraseña, rol.
- **CorteCaja**: id, fecha, total_sistema, total_fisico, diferencia.
