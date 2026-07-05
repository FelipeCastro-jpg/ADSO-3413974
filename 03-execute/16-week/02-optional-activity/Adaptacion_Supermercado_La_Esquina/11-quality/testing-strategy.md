# Estrategia de pruebas

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


## Tipos de prueba

- **Pruebas funcionales manuales**: verificar cada requerimiento funcional (RF-01 a RF-08) registrando ventas, productos y fiados de prueba.
- **Pruebas con el usuario final**: el propietario Carlos Ruiz prueba el flujo de venta real para validar que sea fácil de usar.
- **Pruebas de datos**: verificar que el stock se descuente correctamente y que el corte de caja cuadre con las ventas registradas.

## Casos de prueba prioritarios

1. Registrar una venta con varios productos y verificar el total.
2. Vender más unidades de las que hay en stock (debe rechazar la operación).
3. Registrar un fiado y verificar que quede como pendiente.
4. Generar el corte de caja y verificar que coincida con las ventas del día.
