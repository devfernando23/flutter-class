import 'package:screen_protector/screen_protector.dart';

/// Controlador para impedir capturas de pantalla
class SecurityController {
  /// Activa FLAG_SECURE (bloqueo de capturas)
  Future<void> enableSecureScreen() async {
    await ScreenProtector.preventScreenshotOn();
  }

  /// Desactiva FLAG_SECURE (permite capturas)
  Future<void> disableSecureScreen() async {
    await ScreenProtector.preventScreenshotOff();
  }
}
