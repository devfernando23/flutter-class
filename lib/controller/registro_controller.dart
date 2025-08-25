import '../model/registro_model.dart';

class RegistroController {
  final List<Registro> _registros = [];

  void agregarRegistro(Registro registro) {
    _registros.add(registro);
  }

  List<Registro> get registros => _registros;
}
