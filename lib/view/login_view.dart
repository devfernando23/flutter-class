import 'package:flutter/material.dart';
import '../controller/auth_controller.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController =
      TextEditingController(text: "demo@email.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456");

  final String _defaultEmail = "demo@email.com";
  final String _defaultPassword = "123456";
  bool _obscurePassword = true;
  String _status = "";

  Future<void> _authenticate() async {
    bool success = await _authController.authenticate();
    setState(() {
      _status = success
          ? "Autenticación biométrica exitosa"
          : "Fallo en autenticación biométrica";
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFBA1B38), Color(0xFF2A1939)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Iniciar\nSesión",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBA1B38),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Gmail",
                    style: TextStyle(
                      color: Color(0xFFBA1B38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "demo@email.com",
                      suffixIcon: Icon(Icons.check, color: Colors.green),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBA1B38)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBA1B38), width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Password",
                    style: TextStyle(
                      color: Color(0xFFBA1B38),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "********",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBA1B38)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBA1B38), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_status.isNotEmpty)
                    Center(
                      child: Text(
                        _status,
                        style: TextStyle(
                          color: _status.contains("exitoso") ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  // Botón Ingresar con Email con gradiente
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFBA1B38), Color(0xFF2A1939)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _loginWithEmail,
                        icon: const Icon(Icons.login, color: Colors.white),
                        label: const Text(
                          "Ingresar con Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Botón Autenticarse con Huella con gradiente
                  SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF2A1939), Color(0xFFBA1B38)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: _authenticate,
                        icon: const Icon(Icons.fingerprint, color: Colors.white),
                        label: const Text(
                          "Autenticarse con Huella",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 1.1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}