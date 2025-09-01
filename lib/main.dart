import 'package:flutter/material.dart';
import 'view/login_view.dart';

/// Punto de entrada de la aplicación
void main() {
  runApp(const SecureApp());
}

class SecureApp extends StatelessWidget {
  const SecureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Banking App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LoginView(),
    );
  }
}
