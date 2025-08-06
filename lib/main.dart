// Importamos el paquete base de Flutter para construir la app
import 'package:flutter/material.dart';

// Función principal que inicia la app. Llama a UnitConverterApp.
void main() => runApp(const UnitConverterApp());

// Widget principal de la aplicación
class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp es el contenedor principal del estilo Material Design
    return MaterialApp(
      title: 'Convertidor de Unidades',
      theme: ThemeData(primarySwatch: Colors.indigo), // Color del tema principal
      home: const ConverterPage(), // Página principal de la app
    );
  }
}

// Modelo que representa una unidad de medida (ej. metros, centímetros)
class UnidadDeMedida {
  final String nombre; // Nombre visible de la unidad (ej. "Metros")
  
  // Función que convierte un valor desde esta unidad a una unidad base
  final double Function(double valor) convertirABase;
  
  // Función que convierte desde la unidad base hacia esta unidad
  final double Function(double valor) convertirDesdeBase;

  UnidadDeMedida({
    required this.nombre,
    required this.convertirABase,
    required this.convertirDesdeBase,
  });

  // Esto permite que el nombre de la unidad se muestre directamente en los Dropdowns
  @override
  String toString() => nombre;
} 

// Lista de unidades de longitud disponibles en el conversor
final List<UnidadDeMedida> unidadesLongitud = [
  UnidadDeMedida(
    nombre: 'Metros',
    convertirABase: (v) => v,           // Ya está en unidad base
    convertirDesdeBase: (v) => v,
  ),
  UnidadDeMedida(
    nombre: 'Centímetros',
    convertirABase: (v) => v / 100,     // Convierte a metros
    convertirDesdeBase: (v) => v * 100, // Convierte desde metros
  ),
  UnidadDeMedida(
    nombre: 'Kilómetros',
    convertirABase: (v) => v * 1000,    // Contierte a metros
    convertirDesdeBase: (v) => v / 1000,//Convierte desde kilometros
  ),
];

// Widget con estado donde ocurre la lógica y se muestra la interfaz principal
class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  // Unidad seleccionada en origen y destino
  UnidadDeMedida? unidadOrigen = unidadesLongitud[0];
  UnidadDeMedida? unidadDestino = unidadesLongitud[1];

  // Controlador del campo de texto donde se ingresa el número
  TextEditingController controller = TextEditingController();

  // Resultado del cálculo (texto que se muestra debajo)
  String resultado = '';
  void convertir() {
    final valor = double.tryParse(controller.text); // Intenta convertir a número

    if (valor == null) {
      // Si el valor no es válido, mostramos mensaje de error
      setState(() {
        resultado = 'Entrada inválida';
      });
      return;
    }

    // Paso 1: convertir a unidad base (metros)
    final valorBase = unidadOrigen!.convertirABase(valor);

    // Paso 2: convertir desde unidad base a unidad destino
    final valorConvertido = unidadDestino!.convertirDesdeBase(valorBase);

    // Actualizamos la vista con el resultado
    setState(() {
      resultado =
          '$valor ${unidadOrigen!.nombre} = ${valorConvertido.toStringAsFixed(2)} ${unidadDestino!.nombre}';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Convertidor de Unidades')),

      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaciado interno
        child: Column(
          children: [
            const Text(
              'Conversor de Longitud',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),

            // Campo de entrada numérica
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor a convertir'),
            ),
            const SizedBox(height: 16),

            // Selector de unidad origen
            DropdownButton<UnidadDeMedida>(
              value: unidadOrigen,
              onChanged: (nueva) => setState(() => unidadOrigen = nueva),
              items: unidadesLongitud.map((unidad) {
                return DropdownMenuItem(
                  value: unidad,
                  child: Text(unidad.nombre),
                );
              }).toList(),
            ),

            // Selector de unidad destino
            DropdownButton<UnidadDeMedida>(
              value: unidadDestino,
              onChanged: (nueva) => setState(() => unidadDestino = nueva),
              items: unidadesLongitud.map((unidad) {
                return DropdownMenuItem(
                  value: unidad,
                  child: Text(unidad.nombre),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Botón de conversión
            ElevatedButton(
              onPressed: convertir,
              child: const Text('Convertir'),
            ),

            const SizedBox(height: 16),

            // Texto del resultado
            Text(
              resultado,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
