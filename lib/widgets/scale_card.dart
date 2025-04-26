import 'package:flutter/material.dart';

class ScaleCard extends StatelessWidget {
  final int scaleId;

  const ScaleCard(this.scaleId, {super.key});

  static const List<String> labels = [
    'Péssimo',
    'Ruim',
    'Médio',
    'Bom',
    'Perfeito',
  ];

  static const List<Color> colors = [
    Colors.red,
    Colors.brown,
    Colors.orange,
    Colors.teal,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {

    final String label = labels[scaleId];
    final Color color = colors[scaleId];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}
