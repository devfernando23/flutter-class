// MODELO: Contiene la lógica de negocio (cálculos, datos, reglas)
// No conoce nada de la interfaz gráfica

class TemperatureModel {
  // Convierte Celsius a Fahrenheit
  double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  // Convierte Fahrenheit a Celsius
  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }
}
