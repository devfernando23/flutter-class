import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/registro_controller.dart';
import '../model/registro_model.dart';
import 'dart:io'; // 👈 Para poder usar File()

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final RegistroController _controller = RegistroController();
  final TextEditingController _notaController = TextEditingController();
  String? _ubicacion;
  String? _fotoPath;

  /// Obtener ubicación GPS
  Future<void> _getLocation() async {
    Location location = Location();
    final permiso = await location.requestPermission();
    if (permiso == PermissionStatus.granted) {
      final locData = await location.getLocation();
      setState(() {
        _ubicacion = "${locData.latitude}, ${locData.longitude}";
      });
    }
  }

  /// Tomar foto con cámara
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final foto = await picker.pickImage(source: ImageSource.camera);
    if (foto != null) {
      setState(() {
        _fotoPath = foto.path;
      });
    }
  }

  /// Guardar registro
  void _guardarRegistro() {
    final registro = Registro(
      nota: _notaController.text,
      fotoPath: _fotoPath,
      ubicacion: _ubicacion,
    );
    _controller.agregarRegistro(registro);
    setState(() {
      _notaController.clear();
      _fotoPath = null;
      _ubicacion = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registro guardado")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mi Diario Saludable")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _notaController,
              decoration: const InputDecoration(
                labelText: "Escribe una nota",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _getLocation,
                  icon: const Icon(Icons.location_on),
                  label: const Text("Ubicación"),
                ),
                ElevatedButton.icon(
                  onPressed: _getImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Foto"),
                ),
              ],
            ),
            if (_ubicacion != null) Text("Ubicación: $_ubicacion"),
            if (_fotoPath != null) Image.file(
              File(_fotoPath!),
              height: 120,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarRegistro,
              child: const Text("Guardar Registro"),
            ),
          ],
        ),
      ),
    );
  }
}
