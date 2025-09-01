import 'package:flutter/material.dart';
import '../controller/security_controller.dart';
import 'login_view.dart'; // Importa la vista de login

/// Pantalla protegida que bloquea capturas
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SecurityController _securityController = SecurityController();

  @override
  void initState() {
    super.initState();
    // Bloquea capturas de pantalla al entrar
    _securityController.enableSecureScreen();
  }

  @override
  void dispose() {
    // Libera el bloqueo al salir
    _securityController.disableSecureScreen();
    super.dispose();
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Protegida"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Esta pantalla no permite capturas ni grabaciones 📵",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}