import 'package:local_auth/local_auth.dart';

/// Controlador para la autenticación biométrica
class AuthController {
  final LocalAuthentication auth = LocalAuthentication();

  /// Verifica si el dispositivo tiene biometría
  Future<bool> hasBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  /// Intenta autenticar al usuario usando huella/faceID
  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Autentícate para acceder a la app',
        options: const AuthenticationOptions(
          biometricOnly: true, // Solo huella/faceID
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Error en autenticación biométrica: $e");
      return false;
    }
  }
}