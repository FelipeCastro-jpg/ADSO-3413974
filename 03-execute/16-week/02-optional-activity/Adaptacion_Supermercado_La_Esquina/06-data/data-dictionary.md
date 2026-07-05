# Diccionario de datos

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


| Tabla | Campo | Tipo | Descripción |
|-------|-------|------|-------------|
| Producto | id | Entero | Identificador único |
| Producto | nombre | Texto | Nombre del producto |
| Producto | precio_venta | Decimal | Precio al público |
| Producto | stock | Entero | Cantidad disponible |
| Producto | stock_minimo | Entero | Umbral para alerta de stock bajo |
| Venta | id | Entero | Identificador único |
| Venta | total | Decimal | Valor total de la venta |
| Venta | metodo_pago | Texto | Efectivo, fiado, etc. |
| Fiado | monto | Decimal | Valor pendiente por pagar |
| Fiado | estado | Texto | Pendiente / Pagado |
| Usuario | rol | Texto | Administrador / Cajero |
