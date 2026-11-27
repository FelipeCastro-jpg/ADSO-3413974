# 1. Caracterización de SIGEV y selección de la metodología

**Proyecto:** SIGEV, sistema de gestión de eventos y aforo (en el SRS del equipo también se llama EventFlow Manager).
**Insumo:** SRS compartido del equipo (13 RF y 10 RNF). La caracterización, la comparación y la selección de este documento son individuales.

## 1.1 Caracterización

| Aspecto | Lo que observo en SIGEV | Consecuencia para elegir metodología |
|---|---|---|
| **Tipo de proyecto** | Software nuevo, web y móvil, con **seguridad crítica**: tickets que no se pueden clonar, bitácora inmutable y bloqueo de fraudes en la puerta. Un error en la validación deja entrar gente sin ticket o supera el aforo legal. | La calidad técnica y las **pruebas** pesan más que la documentación extensa. |
| **Tamaño del equipo** | **2 aprendices**: Andrés C. (backend, QA y base de datos) y Brenda G. (UI/UX y frontend). | Equipo mínimo, ideal para **programación en pareja**; no hay espacio para roles separados de analista, diseñador y probador. |
| **Estabilidad de los requisitos** | **Baja en los detalles.** En pocas versiones del SRS se agregaron el QR dinámico, el modo offline, las alertas anti-phishing y la verificación con foto. Las reglas anti-fraude seguirán cambiando a medida que se prueben. | Se necesitan ciclos muy cortos y cambios baratos: diseño simple y pruebas que avisen si un cambio rompe algo. |
| **Disponibilidad del cliente** | El instructor (Product Owner) revisa cada semana. Brenda conoce la experiencia del usuario y está disponible **a diario** como **representante del cliente** para resolver dudas de uso. | Hay un «cliente en sitio» parcial: el instructor decide el alcance y Brenda resuelve las dudas del día a día. |

## 1.2 Comparación de metodologías

Escala de 1 (no encaja) a 5 (encaja muy bien). Los criterios y sus pesos salen de la caracterización.

| Criterio | Peso | RUP | Scrum | **XP** | RAD |
|---|---|---|---|---|---|
| K1. Absorbe cambios frecuentes de detalle | 25 % | 2 | 5 | **5** | 4 |
| K2. Asegura calidad técnica y pruebas (seguridad crítica) | 25 % | 4 | 3 | **5** | 2 |
| K3. Aprovecha un equipo de 2 personas | 20 % | 2 | 4 | **5** | 3 |
| K4. Entregas pequeñas y frecuentes | 15 % | 3 | 4 | **5** | 4 |
| K5. Produce la documentación exigida por el programa | 15 % | 5 | 4 | **2** | 2 |
| **Total ponderado** | 100 % | **3,10** | **4,00** | **4,55** | **3,00** |

Cálculo de XP: 5·0,25 + 5·0,25 + 5·0,20 + 5·0,15 + 2·0,15 = **4,55**.

- **RUP:** documenta muy bien (K5), pero sus 4 fases y muchos roles son pesados para 2 personas y encarecen cada cambio. Se descarta.
- **Scrum:** organiza bien el trabajo y absorbe cambios, pero **no dice cómo asegurar la calidad del código**. En SIGEV la falla técnica es el riesgo principal (fraude y aforo). Queda segundo.
- **XP:** sus prácticas atacan justo el riesgo del proyecto: **pruebas primero (TDD)**, **programación en pareja**, **integración continua**, **diseño simple** y **entregas pequeñas**. Su debilidad es la documentación (K5).
- **RAD:** prioriza la velocidad con prototipos y sacrifica el rigor que exige un sistema de seguridad. Se descarta.

## 1.3 Metodología seleccionada: XP (Programación Extrema)

**Justificación ligada a las características:**
1. **Seguridad crítica →** TDD: cada regla de validación (código vigente, ticket no usado, aforo) se escribe primero como prueba automática.
2. **Requisitos que cambian →** iteraciones de **1 semana** y diseño simple con refactorización; un cambio en una regla anti-fraude no obliga a rediseñar todo.
3. **Equipo de 2 →** programación en pareja en las partes críticas (validación en puerta y bitácora).
4. **Cliente parcial →** el instructor prioriza en el **juego de planificación** semanal; Brenda actúa como cliente en sitio para las dudas de uso.
5. **Debilidad en documentación (K5) →** se compensa con una regla de equipo: una historia **no está terminada** hasta que su caso de uso, su matriz y su modelo estén en el repositorio.

**Prácticas de XP que se usan en el análisis:**

| Práctica | Uso en SIGEV |
|---|---|
| Historias de usuario | HU-01 a HU-12 del SRS, escritas como tarjetas y estimadas en puntos |
| Juego de planificación | Al inicio de cada iteración, con el instructor, se eligen las historias |
| Spike (exploración corta) | Para dudas técnicas del análisis, por ejemplo cómo funciona un QR dinámico |
| Tarjetas CRC | Para descubrir las clases del dominio antes de modelarlas |
| Pruebas de aceptación | Cada caso de uso crítico tiene criterios de aceptación verificables |
| Integración continua | Commits pequeños y frecuentes en el fork |
