import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../model/user_model.dart';

/// VISTA: UI e interacción con el usuario. No contiene lógica de negocio.
class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  final UserController _userController = UserController();

  // Controladores de texto
  final TextEditingController _nombresCtrl = TextEditingController();
  final TextEditingController _apellidosCtrl = TextEditingController();
  final TextEditingController _dniCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  // Género seleccionado
  String? _generoSeleccionado;

  // Estado UI
  bool _obscurePassword = true;
  String _resultado = '';

  void _onRegistrar() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() => _resultado = '');
      return;
    }

    final msg = _userController.registrarUsuario(
      nombres: _nombresCtrl.text,
      apellidos: _apellidosCtrl.text,
      dni: _dniCtrl.text,
      genero: _generoSeleccionado!,
      email: _emailCtrl.text,
      password: _passwordCtrl.text,
    );

    setState(() => _resultado = msg);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _onLimpiar() {
    _formKey.currentState?.reset();
    _nombresCtrl.clear();
    _apellidosCtrl.clear();
    _dniCtrl.clear();
    _emailCtrl.clear();
    _passwordCtrl.clear();
    setState(() {
      _generoSeleccionado = null;
      _resultado = '';
      _obscurePassword = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Usuario (MVC)"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                    ),
                  )
                ),

                const Text(
                  "Ingrese sus datos:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Nombres
                TextFormField(
                  controller: _nombresCtrl,
                  decoration: const InputDecoration(
                    labelText: "Nombres",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => User.validateNombres(value),
                ),
                const SizedBox(height: 16),

                // Apellidos
                TextFormField(
                  controller: _apellidosCtrl,
                  decoration: const InputDecoration(
                    labelText: "Apellidos",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => User.validateApellidos(value),
                ),
                const SizedBox(height: 16),

                // DNI
                TextFormField(
                  controller: _dniCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "DNI",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => User.validateDni(value),
                ),
                const SizedBox(height: 16),

                // Género
                DropdownButtonFormField<String>(
                  value: _generoSeleccionado,
                  items: const [
                    DropdownMenuItem(
                      value: "Masculino",
                      child: Text("Masculino"),
                    ),
                    DropdownMenuItem(
                      value: "Femenino",
                      child: Text("Femenino"),
                    ),
                    DropdownMenuItem(value: "Otro", child: Text("Otro")),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Género",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (valor) =>
                      setState(() => _generoSeleccionado = valor),
                  validator: (value) => User.validateGenero(value),
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => User.validateEmail(value),
                ),
                const SizedBox(height: 16),

                // Contraseña
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) => User.validatePassword(value),
                ),
                const SizedBox(height: 20),

                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _onRegistrar,
                      child: const Text("Registrar"),
                    ),
                    ElevatedButton(
                      onPressed: _onLimpiar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Limpiar"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Resultado
                Text(_resultado, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
