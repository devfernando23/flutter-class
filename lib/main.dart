import 'package:flutter/material.dart';
import 'view/login_view.dart';

void main() {
  runApp(const MultiSecureApiApp());
}

class MultiSecureApiApp extends StatelessWidget {
  const MultiSecureApiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Security - Apis CRUD',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LoginView(),
    );
  }
}
