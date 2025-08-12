// VISTA: Contiene la interfaz gráfica y la interacción con el usuario.
// No hace cálculos, sino que llama al controlador.

import 'package:flutter/material.dart';
import '../controller/temperature_controller.dart';

class ConverterView extends StatefulWidget {
  const ConverterView({super.key});

  @override
  State<ConverterView> createState() => _ConverterViewState();
}

class _ConverterViewState extends State<ConverterView> {
  // Controlador para manejar la lógica
  final TemperatureController _controller = TemperatureController();

  // Controlador del campo de texto donde el usuario ingresa el valor
  final TextEditingController _inputController = TextEditingController();

  // Variables para almacenar la unidad seleccionada
  String _unidadOrigen = 'Celsius';
  String _unidadDestino = 'Fahrenheit';

  // Texto que mostrará el resultado
  String _resultado = '';

  // Lista de unidades disponibles
  final List<String> _unidades = ['Celsius', 'Fahrenheit'];

  // Método que se ejecuta al presionar el botón "Convertir"
  void _convertir() {
    // Convertir el texto a número
    final valor = double.tryParse(_inputController.text);

    if (valor == null) {
      // Si no es número válido, mostrar error
      setState(() {
        _resultado = 'Entrada inválida';
      });
      return;
    }

    // Usar el controlador para hacer la conversión
    final valorConvertido =
        _controller.convertir(_unidadOrigen, _unidadDestino, valor);

    // Actualizar la interfaz con el resultado
    setState(() {
      _resultado =
          '$valor $_unidadOrigen = ${valorConvertido.toStringAsFixed(2)} $_unidadDestino';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de Temperatura')),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Márgenes internos
        child: Column(
          children: [
            // Campo para que el usuario ingrese el valor
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese valor',
              ),
            ),
            const SizedBox(height: 16),

            // Selector de unidad de origen
            DropdownButton<String>(
              value: _unidadOrigen,
              onChanged: (value) => setState(() => _unidadOrigen = value!),
              items: _unidades
                  .map((unidad) => DropdownMenuItem(
                        value: unidad,
                        child: Text(unidad),
                      ))
                  .toList(),
            ),

            // Selector de unidad de destino
            DropdownButton<String>(
              value: _unidadDestino,
              onChanged: (value) => setState(() => _unidadDestino = value!),
              items: _unidades
                  .map((unidad) => DropdownMenuItem(
                        value: unidad,
                        child: Text(unidad),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            // Botón para ejecutar la conversión
            ElevatedButton(
              onPressed: _convertir,
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 16),

            // Texto que muestra el resultado
            Text(
              _resultado,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
