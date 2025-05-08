import 'package:flutter/material.dart';
import 'package:future_home_app/widgets/stars_rating.dart';

class SessionCardDetails extends StatelessWidget {
  final int rating;
  final String title;
  final List<Map<String, String?>> details;

  const SessionCardDetails({
    required this.rating,
    required this.title,
    required this.details,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                StarsRating(rating: rating, disabled: true, size: 20.0),
              ],
            ),
            const SizedBox(height: 12),
            ...details.map((detail) {
              final label = detail['label'] ?? '';
              final value = detail['value'] ?? 'Não disponível';
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$label:',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
