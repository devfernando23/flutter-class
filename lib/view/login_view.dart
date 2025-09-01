import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import 'home_view.dart';

/// Vista de Login con huella digital y email/password
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authController = AuthController();
  String _status = "Esperando autenticación...";

  // Controladores para email y password
  final TextEditingController _emailController =
      TextEditingController(text: "demo@email.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456");

  // Credenciales por defecto
  final String _defaultEmail = "demo@email.com";
  final String _defaultPassword = "123456";

  Future<void> _authenticate() async {
    bool success = await _authController.authenticate();
    setState(() {
      _status = success ? "Autenticación biométrica exitosa" : "Fallo en autenticación biométrica";
    });

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    }
  }

  void _loginWithEmail() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email == _defaultEmail && password == _defaultPassword) {
      setState(() {
        _status = "Login con email exitoso";
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    } else {
      setState(() {
        _status = "Email o contraseña incorrectos";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Seguro")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loginWithEmail,
                child: const Text("Ingresar con Email"),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _authenticate,
                icon: const Icon(Icons.fingerprint),
                label: const Text("Autenticarse con Huella"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}