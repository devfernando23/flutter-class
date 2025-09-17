import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class CompassView extends StatefulWidget {
  const CompassView({super.key});

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brújula"),
        backgroundColor: const Color(0xFFBA1B38),
      ),
      body: Center(
        child: StreamBuilder<CompassEvent>(
          stream: FlutterCompass.events,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.heading == null) {
              return const Text(
                "No se detecta sensor de brújula",
                style: TextStyle(fontSize: 18),
              );
            }

            final direction = snapshot.data!.heading!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Caja de la brújula
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Círculo de la brújula y marcas
                      Transform.rotate(
                        angle: -direction * pi / 180,
                        child: CustomPaint(
                          size: const Size(250, 250),
                          painter: CompassPainter(),
                        ),
                      ),
                      // Flecha roja apuntando al norte
                      Icon(
                        Icons.navigation,
                        size: 80,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "${direction.toStringAsFixed(2)}°",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Pintor de brújula con diseño similar a la imagen
class CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Marcas grandes y pequeñas
    for (int i = 0; i < 40; i++) {
      final angle = (pi * 2 / 40) * i;
      final isMajor = i % 10 == 0;
      final length = isMajor ? radius * 0.18 : radius * 0.09;
      final paint = Paint()
        ..color = Colors.white
        ..strokeWidth = isMajor ? 4 : 2;

      final start = Offset(
        center.dx + (radius - length) * cos(angle),
        center.dy + (radius - length) * sin(angle),
      );
      final end = Offset(
        center.dx + (radius - 8) * cos(angle),
        center.dy + (radius - 8) * sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }

    // Cruz central
    final crossPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(center.dx - 25, center.dy),
      Offset(center.dx + 25, center.dy),
      crossPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - 25),
      Offset(center.dx, center.dy + 25),
      crossPaint,
    );

    // Cardinales
    final cardinalPoints = ['N', 'E', 'S', 'W'];
    final cardinalAngles = [-pi / 2, 0, pi / 2, pi]; // <-- Ángulos corregidos
    for (int i = 0; i < 4; i++) {
      final dx = center.dx + radius * 0.72 * cos(cardinalAngles[i]);
      final dy = center.dy + radius * 0.72 * sin(cardinalAngles[i]);
      final isNorth = i == 0;
      final textPainter = TextPainter(
        text: TextSpan(
          text: cardinalPoints[i],
          style: TextStyle(
            color: isNorth ? Colors.red : Colors.white,
            fontSize: isNorth ? 32 : 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final offset = Offset(
        dx - textPainter.width / 2,
        dy - textPainter.height / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}