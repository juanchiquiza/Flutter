# 📱 User Addresses App

Aplicación móvil desarrollada en **Flutter** que permite:

- Crear un **usuario** con nombre, apellido y fecha de nacimiento.
- Agregar múltiples **direcciones** asociadas al usuario (país, departamento, municipio).
- Visualizar en cualquier momento los datos del usuario y sus direcciones.

El proyecto sigue **Clean Architecture**, **State Management con Riverpod** y utiliza **SQLite** para persistencia local.  
Además, se implementa **Dependency Injection con GetIt**.

---

## 🛠️ Tecnologías Implementadas

### ⚙️ Framework y Lenguaje
- **Flutter 3.x**
- **Dart**

### 🎨 UI
- **Material Design Widgets**
- **Riverpod** (`flutter_riverpod`) → manejo de estados reactivos
- **Clean Architecture UI Flow** → separación en `presentation`, `application`, `domain`, `infrastructure`

### 🗄️ Persistencia
- **SQLite** con el paquete `sqflite`
- **DAOs (Data Access Objects)** para abstracción de base de datos
- Migraciones básicas incluidas (`users` y `addresses`)

### 🧩 Arquitectura
- **Clean Architecture** → capas bien separadas
    - **Domain** → entidades + casos de uso
    - **Application** → lógica de estado (Riverpod Notifiers/Providers)
    - **Infrastructure** → DAOs, repositorios, SQLite
    - **Presentation** → pantallas, widgets, formularios
- **Dependency Injection** → con `get_it`


Se agrega evidencia del funcionamiento de la app