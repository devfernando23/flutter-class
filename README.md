# 🔐 Multi Secure API App

Proyecto **Flutter** demostrativo que combina **seguridad** y **consumo de APIs REST**.  
Incluye:

- ✅ **Login seguro**
  - Opción 1: Autenticación con **email + contraseña** usando `reqres.in`
  - Opción 2: Autenticación con **biometría** (huella digital / FaceID)
- ✅ **Protección de pantalla** (bloqueo de capturas tipo apps bancarias)
- ✅ **Consumo de múltiples APIs públicas**
  - **Usuarios (ReqRes)** → CRUD completo
  - **Posts (JSONPlaceholder)** → lectura
  - **Productos (Fake Store)** → lectura
- ✅ Arquitectura **MVC** (Model, View, Controller) para código organizado.

---

## 📂 Estructura del proyecto

lib/
├── main.dart
├── controller/
│ ├── auth_controller.dart
│ ├── users_controller.dart
│ ├── posts_controller.dart
│ └── products_controller.dart
├── model/
│ ├── user_model.dart
│ ├── post_model.dart
│ └── product_model.dart
└── view/
├── login_view.dart
├── home_view.dart
├── users_view.dart
├── posts_view.dart
└── products_view.dart

yaml
Copiar código

---

## 🚀 Configuración rápida

### 1. Clonar el repo
```bash
git clone https://github.com/tuusuario/multi-secure-api-app.git
cd multi-secure-api-app
2. Instalar dependencias
bash
Copiar código
flutter pub get
3. Configuración Android
En android/app/build.gradle:

gradle
Copiar código
defaultConfig {
    minSdkVersion 23
}
En android/app/src/main/kotlin/.../MainActivity.kt:

kotlin
Copiar código
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() { }
En AndroidManifest.xml:

xml
Copiar código
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />

4. Configuración iOS

En ios/Runner/Info.plist:

<key>NSFaceIDUsageDescription</key>
<string>Se usa para autenticar al usuario de forma segura.</string>


📱 Funcionalidades
🔐 Login

Con credenciales (email + password)

Con biometría (huella / FaceID)

👤 Usuarios (CRUD completo)

Listar usuarios (GET)

Crear usuario (POST)

Editar usuario (PUT)

Eliminar usuario (DELETE)

📝 Posts

Listado de publicaciones desde JSONPlaceholder

🛒 Productos

Listado de productos desde Fake Store API

📸 Screenshots sugeridos

 Login con email/contraseña

 Login con huella

 Menú principal con las 3 secciones

 Vista de CRUD usuarios

 Vista de posts

 Vista de productos

🛠️ Dependencias usadas

http

local_auth

screen_protector

cupertino_icons