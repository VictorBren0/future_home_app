import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

TextInputFormatter moneyInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
      final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      final value = double.tryParse(text) ?? 0.0;
      final formattedText = formatter.format(value / 100);
      return newValue.copyWith(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    });
  }