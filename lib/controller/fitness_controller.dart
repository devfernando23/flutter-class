import 'package:sensors_plus/sensors_plus.dart';
import 'package:light_sensor/light_sensor.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import '../model/fitness_model.dart';

class FitnessController {
  final FitnessModel _fitness = FitnessModel();
  double _lastZ = 0;
  final double _threshold = 1.2;

  FitnessModel get fitness => _fitness;

  void startTracking(void Function(FitnessModel) onUpdate) {
    // Acelerómetro → pasos
    accelerometerEvents.listen((event) {
      double z = event.z;
      if ((_lastZ - z).abs() > _threshold) {
        _fitness.steps++;
        _fitness.distance = _fitness.steps * 0.8;
        _fitness.calories = _fitness.steps * 0.04;
        onUpdate(_fitness);
      }
      _lastZ = z;
    });

    // Sensor de luz (light_sensor)
    LightSensor.hasSensor().then((has) {
      if (has) {
        LightSensor.luxStream().listen((lux) {
          print("Sensor de luz: $lux lux");
        });
      } else {
        print("Sensor de luz no disponible");
      }
    });

    // Sensor de proximidad
    ProximitySensor.events.listen((int isNear) {
      print(isNear > 0 ? "Objeto cercano" : "Nada cerca");
    });
  }
}
