import 'package:flutter/material.dart';

class StarsRating extends StatelessWidget {
  final int rating;
  final double size;
  final bool disabled;
  final void Function(int)? onChange;

  const StarsRating({
    required this.rating,
    this.size = 25.0,
    this.disabled = false,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: disabled ? null : () => onChange?.call(index + 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0), // controle o espaçamento aqui
            child: Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: size,
            ),
          ),
        );
      }),
    );
  }
}
