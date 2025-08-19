import 'package:flutter/material.dart';
import 'view/registro_view.dart';

void main() {
  runApp(const WidgetsComunesApp());
}

class WidgetsComunesApp extends StatelessWidget {
  const WidgetsComunesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro con MVC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const RegistroPage(),
    );
  }
}
