// MODELO: Contiene datos y lógica de negocio del usuario.
class User {
  String nombres;
  String apellidos;
  String dni;
  String genero;
  String email;
  String password;

  User({
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.genero,
    required this.email,
    required this.password,
  });

  static const int minPasswordLen = 6;

  // Validaciones (estáticas para poder llamarlas desde la vista)
  static String? validateNombres(String? value) {
    if (value == null || value.trim().isEmpty) return 'Los nombres son obligatorios';
    if (value.trim().length < 2) return 'Debe tener al menos 2 caracteres';
    return null;
  }

  static String? validateApellidos(String? value) {
    if (value == null || value.trim().isEmpty) return 'Los apellidos son obligatorios';
    return null;
  }

  static String? validateDni(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'El DNI es obligatorio';
    if (v.length != 8) return 'El DNI debe tener 8 dígitos';
    if (!RegExp(r'^[0-9]+$').hasMatch(v)) return 'El DNI debe ser numérico';
    return null;
  }

  static String? validateGenero(String? value) {
    if (value == null || value.isEmpty) return 'Seleccione un género';
    return null;
  }

  static String? validateEmail(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'El email es obligatorio';
    final emailRegex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[A-Za-z]{2,}$');
    if (!emailRegex.hasMatch(v)) return 'Formato de email inválido';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    if (value.length < minPasswordLen) return 'La contraseña debe tener al menos $minPasswordLen caracteres';
    return null;
  }
}
