import 'package:flutter/material.dart';
import 'view/converter_view.dart'; // Importamos la vista principal

// Función principal que inicia la aplicación
void main() {
  // runApp: método que dibuja el widget raíz de la app
  runApp(const TemperatureApp());
}

// Widget raíz (Stateless porque no cambia su estado interno)
class TemperatureApp extends StatelessWidget {
  const TemperatureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Temperatura',
      theme: ThemeData(primarySwatch: Colors.blue), // Tema general
      home: const ConverterView(), // Vista inicial de la app
    );
  }
}