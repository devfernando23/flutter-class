// CONTROLADOR: Conecta la vista con el modelo.
// La vista le pasa datos, el controlador los procesa con ayuda del modelo
// y devuelve el resultado a la vista.

import '../model/temperature_model.dart';

class TemperatureController {
  // Instancia del modelo
  final TemperatureModel _model = TemperatureModel();

  // Método que decide qué conversión hacer según las unidades seleccionadas
  double convertir(String tipoOrigen, String tipoDestino, double valor) {
    if (tipoOrigen == tipoDestino) {
      // Si ambas unidades son iguales, no hace conversión
      return valor;
    } else if (tipoOrigen == 'Celsius' && tipoDestino == 'Fahrenheit') {
      return _model.celsiusToFahrenheit(valor);
    } else if (tipoOrigen == 'Fahrenheit' && tipoDestino == 'Celsius') {
      return _model.fahrenheitToCelsius(valor);
    } else {
      throw Exception('Conversión no soportada');
    }
  }
}
