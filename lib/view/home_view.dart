import 'package:flutter/material.dart';
import '../controller/device_controller.dart';
import 'fitness_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DeviceController _deviceController = DeviceController();
  String _deviceId = "Cargando...";

  @override
  void initState() {
    super.initState();
    _loadDeviceId();
  }

  Future<void> _loadDeviceId() async {
    final device = await _deviceController.getDeviceInfo();
    setState(() {
      _deviceId = device.deviceId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unique Code + Fitness")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Device ID:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(_deviceId, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FitnessView()),
                );
              },
              child: const Text("Ir a Fitness App"),
            )
          ],
        ),
      ),
    );
  }
}
