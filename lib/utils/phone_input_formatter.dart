import 'package:flutter/services.dart';

TextInputFormatter phoneInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

      if (digits.length > 11) digits = digits.substring(0, 11);

      String formatted = digits;

      if (digits.length >= 2) {
        formatted = '(${digits.substring(0, 2)})';
        if (digits.length >= 7) {
          formatted += ' ${digits.substring(2, 7)}-${digits.substring(7)}';
        } else if (digits.length > 2) {
          formatted += ' ${digits.substring(2)}';
        }
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });
  }