import '../model/user_model.dart';

/// CONTROLADOR: Conecta la vista con el modelo.
class UserController {
  User? _user;

  // Crea usuario si es válido
  String registrarUsuario({
    required String nombres,
    required String apellidos,
    required String dni,
    required String genero,
    required String email,
    required String password,
  }) {
    final usuario = User(
      nombres: nombres.trim(),
      apellidos: apellidos.trim(),
      dni: dni.trim(),
      genero: genero,
      email: email.trim(),
      password: password,
    );

    // Aquí podrías llamar a todas las validaciones del modelo si quieres validar antes de crear
    _user = usuario;
    return "Usuario registrado: ${_user!.nombres} ${_user!.apellidos}, DNI ${_user!.dni}, Género ${_user!.genero}, Email ${_user!.email}";
  }
}
