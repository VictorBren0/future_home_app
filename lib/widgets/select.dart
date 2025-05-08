import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? value;
  final void Function(String) onChange;
  final bool isRequired;
  final String? Function(String?)? validator;

  const Select({
    required this.label,
    required this.options,
    required this.value,
    required this.onChange,
    this.validator,
    this.isRequired = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: options.contains(value) ? value : null,
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChange(newValue);
        }
      },
      icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        border: const OutlineInputBorder(),
        label: RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
            children:
                isRequired
                    ? [
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Color(0xFFB00020),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]
                    : [],
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),
      dropdownColor: Colors.grey[100],
      items:
          options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(
                option,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
    );
  }
}
