import 'package:flutter/material.dart';
import 'view/registro_view.dart';

void main() => runApp(const DiarioApp());

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Diario Saludable',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RegistroView(),
    );
  }
}
