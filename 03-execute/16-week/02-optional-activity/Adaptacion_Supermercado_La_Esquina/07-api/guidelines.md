# Guías de API

> Estado: 🟢 | Última actualización: 2026-07-05
> Autor: Andrés Felipe Castro Bedoya | Equipo: Andrés Felipe Castro Bedoya


## Alcance

El sistema es una aplicación local monolítica; no expone una API pública hacia internet. Sin embargo, internamente la lógica de negocio se organiza como funciones/servicios reutilizables entre pantallas, siguiendo estas guías:

- Nombrar operaciones con verbos claros: `registrarVenta`, `actualizarStock`, `generarCorteCaja`.
- Toda operación que modifique datos debe validar reglas de negocio antes de guardar (ver [02-domain/entities-and-rules.md](../02-domain/entities-and-rules.md)).
- Las respuestas de error deben ser mensajes claros en español, pensados para usuarios sin experiencia técnica.
