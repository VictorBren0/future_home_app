import 'package:flutter/material.dart';

class ListTypeResidence extends StatelessWidget {
  final String selected;
  final void Function(String) onChange;

  const ListTypeResidence({
    required this.selected,
    required this.onChange,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => onChange('casa'),
            icon: const Icon(Icons.home),
            label: const Text('Casa'),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selected == 'casa' ? Colors.deepOrange : Colors.grey[300],
              foregroundColor:
                  selected == 'casa' ? Colors.white : Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => onChange('apartamento'),
            icon: const Icon(Icons.apartment),
            label: const Text('Apartamento'),
            style: ElevatedButton.styleFrom(
              backgroundColor: selected == 'apartamento'
                  ? Colors.deepOrange
                  : Colors.grey[300],
              foregroundColor: selected == 'apartamento'
                  ? Colors.white
                  : Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
