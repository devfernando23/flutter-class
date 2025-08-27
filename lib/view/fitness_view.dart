import 'package:flutter/material.dart';
import '../controller/fitness_controller.dart';
import '../model/fitness_model.dart';

class FitnessView extends StatefulWidget {
  const FitnessView({super.key});

  @override
  State<FitnessView> createState() => _FitnessViewState();
}

class _FitnessViewState extends State<FitnessView> {
  final FitnessController _fitnessController = FitnessController();
  FitnessModel _fitness = FitnessModel();

  @override
  void initState() {
    super.initState();
    _fitnessController.startTracking((updated) {
      setState(() {
        _fitness = updated;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fitness Tracker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pasos: ${_fitness.steps}", style: const TextStyle(fontSize: 22)),
            Text("Distancia: ${_fitness.distance.toStringAsFixed(2)} m",
                style: const TextStyle(fontSize: 22)),
            Text("Calorías: ${_fitness.calories.toStringAsFixed(2)} kcal",
                style: const TextStyle(fontSize: 22)),
          ],
        ),
      ),
    );
  }
}
