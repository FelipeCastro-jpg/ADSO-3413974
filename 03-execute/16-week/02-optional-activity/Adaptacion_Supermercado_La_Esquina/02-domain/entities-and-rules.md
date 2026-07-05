# Entidades y reglas de negocio

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


## Entidades principales

- **Producto**: nombre, código, precio de venta, precio de compra, stock actual, stock mínimo.
- **Venta**: fecha, productos vendidos, cantidades, total, método de pago, usuario que la registró.
- **DetalleVenta**: producto, cantidad, precio unitario, subtotal (línea de una venta).
- **Cliente**: nombre, identificación, información de contacto (para manejo de fiados).
- **Fiado / Crédito**: cliente, monto, fecha, estado (pendiente/pagado), abonos.
- **Usuario**: nombre, rol (administrador/cajero), credenciales de acceso.
- **CorteCaja**: fecha, total registrado en sistema, total físico contado, diferencia.

## Reglas de negocio

1. Una venta no puede registrarse si el producto no tiene stock suficiente.
2. Al registrar una venta, el stock del producto se descuenta automáticamente.
3. Una venta a crédito (fiado) debe estar asociada a un cliente identificado.
4. Solo el administrador puede editar precios, eliminar productos o crear usuarios.
5. El corte de caja se genera una vez al día y compara el efectivo físico contra lo registrado en el sistema.
6. Un producto con stock igual o menor al stock mínimo debe alertar al administrador.
