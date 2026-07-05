# Eventos de dominio

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


| Evento | Cuándo ocurre | Efecto |
|--------|---------------|--------|
| VentaRegistrada | El cajero confirma una venta | Se descuenta stock, se genera tiquete, se actualiza el corte de caja del día |
| ProductoActualizado | El administrador edita precio o stock de un producto | Se refleja el nuevo valor en el catálogo e inventario |
| StockBajo | El stock de un producto llega al mínimo configurado | Se genera una alerta visible para el administrador |
| FiadoCreado | Una venta se registra como crédito | Se crea una deuda pendiente asociada al cliente |
| FiadoPagado | El cliente paga total o parcialmente su fiado | Se actualiza el saldo pendiente del cliente |
| CorteCajaGenerado | El usuario cierra el día | Se compara el efectivo físico contra el registrado y se guarda el reporte |
