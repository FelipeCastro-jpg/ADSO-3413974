# 🧠 Git Commits — Guía Completa desde Cero

> Aprende a usar commits de Git de forma clara, práctica y eficiente.

---

## 📌 ¿Qué es un commit?

Un **commit** es una "foto" del estado de tu proyecto en un momento específico.  
Git guarda esa foto y te permite volver a ella cuando quieras.

```
Working Directory → Staging Area → Repositorio (commits)
     (editas)          (git add)       (git commit)
```

---

## ⚡ Flujo básico de trabajo

```bash
# 1. Ver qué archivos cambiaron
git status

# 2. Agregar archivos al staging (preparar la foto)
git add archivo.txt          # Un archivo específico
git add .                    # Todos los archivos modificados

# 3. Hacer el commit (tomar la foto)
git commit -m "mensaje claro del cambio"
```

---

## ✍️ Escribir buenos mensajes de commit

Un buen mensaje responde: **¿Qué hice y por qué?**

### ✅ Ejemplos buenos
```
feat: agregar formulario de login
fix: corregir error de validación en email
docs: actualizar README con instrucciones de instalación
refactor: simplificar función de cálculo de impuestos
```

### ❌ Ejemplos malos
```
cambios
arreglé cosas
commit
asdfgh
```

### 📐 Convención popular: **Conventional Commits**

| Prefijo    | Cuándo usarlo                          |
|------------|----------------------------------------|
| `feat:`    | Nueva funcionalidad                    |
| `fix:`     | Corrección de bug                      |
| `docs:`    | Cambios en documentación               |
| `style:`   | Formato, espacios (sin cambio lógico)  |
| `refactor:`| Reestructura de código sin nuevo feat  |
| `test:`    | Agregar o corregir tests               |
| `chore:`   | Tareas de mantenimiento                |

---

## 🔧 Comandos esenciales de commits

### Ver el historial
```bash
git log                   # Historial completo
git log --oneline         # Historial compacto (una línea por commit)
git log --oneline --graph # Con árbol de ramas visual
```

### Commit rápido (add + commit en uno)
```bash
git commit -am "mensaje"
# ⚠️ Solo funciona con archivos ya rastreados (tracked)
```

### Modificar el último commit
```bash
git commit --amend -m "mensaje corregido"
# ⚠️ Solo úsalo si aún NO has hecho push
```

### Commit con descripción detallada
```bash
git commit -m "feat: nueva página de perfil

- Añade foto de usuario
- Muestra historial de actividad
- Responsive para móvil"
```

---

## 🕵️ Inspeccionar commits

```bash
# Ver qué cambió en el último commit
git show

# Ver qué cambió en un commit específico
git show abc1234

# Ver diferencias antes de hacer commit
git diff               # Cambios no staged
git diff --staged      # Cambios en staging
```

---

## ⏪ Deshacer y revertir

### Sacar un archivo del staging (sin perder cambios)
```bash
git restore --staged archivo.txt
```

### Descartar cambios en un archivo (¡irreversible!)
```bash
git restore archivo.txt
```

### Volver a un commit anterior (sin borrar historial) ✅ Seguro
```bash
git revert abc1234
# Crea un nuevo commit que deshace los cambios
```

### Resetear al estado de un commit (⚠️ peligroso si ya hiciste push)
```bash
git reset --soft HEAD~1   # Vuelve 1 commit atrás, mantiene cambios en staging
git reset --mixed HEAD~1  # Vuelve 1 commit atrás, mantiene cambios en working dir
git reset --hard HEAD~1   # Vuelve 1 commit atrás y BORRA los cambios
```

---

## 🏷️ Etiquetas (Tags)

Los tags sirven para marcar versiones importantes.

```bash
git tag v1.0.0                          # Tag ligero
git tag -a v1.0.0 -m "Primera versión" # Tag anotado (recomendado)
git tag                                 # Ver todos los tags
git push origin v1.0.0                 # Subir un tag
```

---

## 🌿 Commits en ramas

```bash
# Crear y moverse a una rama nueva
git checkout -b feature/login

# Hacer commits normalmente...
git add .
git commit -m "feat: estructura del login"

# Volver a main y fusionar
git checkout main
git merge feature/login
```

---

## 🍒 Cherry-pick — Copiar un commit de otra rama

```bash
git cherry-pick abc1234
# Aplica ese commit específico en tu rama actual
```

---

## 📦 Stash — Guardar cambios temporalmente

```bash
git stash              # Guardar cambios sin commitear
git stash list         # Ver stashes guardados
git stash pop          # Recuperar el último stash
git stash drop         # Eliminar el último stash
```

---

## 🔍 Buscar en el historial

```bash
# Buscar por mensaje de commit
git log --oneline --grep="login"

# Ver quién modificó cada línea de un archivo
git blame archivo.txt

# Buscar cuándo se introdujo un bug (modo interactivo)
git bisect start
git bisect bad          # El commit actual tiene el bug
git bisect good v1.0.0  # Esta versión estaba bien
```

---

## 📋 Referencia rápida

| Acción                         | Comando                              |
|--------------------------------|--------------------------------------|
| Preparar todos los cambios     | `git add .`                          |
| Hacer commit                   | `git commit -m "mensaje"`            |
| Ver historial compacto         | `git log --oneline`                  |
| Ver diferencias staged         | `git diff --staged`                  |
| Deshacer último commit (soft)  | `git reset --soft HEAD~1`            |
| Revertir commit (seguro)       | `git revert <hash>`                  |
| Guardar cambios temporalmente  | `git stash`                          |
| Modificar último commit        | `git commit --amend -m "nuevo msg"`  |
| Copiar commit de otra rama     | `git cherry-pick <hash>`             |

---

## 💡 Buenas prácticas

1. **Commitea seguido** — pequeños cambios son más fáciles de rastrear y revertir.
2. **Un commit = una idea** — no mezcles varios cambios no relacionados.
3. **Mensajes en imperativo** — "Agrega login" en lugar de "Agregué login".
4. **Nunca hagas `--hard` sin estar seguro** — primero revisa con `git log`.
5. **Usa ramas** — nunca desarrolles directamente en `main`.

---

*Hecho con ❤️ para aprender Git de verdad.*
