import 'package:flutter_test/flutter_test.dart';
import 'package:future_home_app/utils/generate_unique_id.dart';

void main() {
  group('generateUniqueId', () {
    test('Gera uma string não vazia', () {
      final id = generateUniqueId();
      expect(id, isNotEmpty);
    });
    test('Gera IDs diferentes em chamadas consecutivas', () async {
      final id1 = generateUniqueId();
      await Future.delayed(Duration(microseconds: 1)); // evita mesmo microTimestamp
      final id2 = generateUniqueId();
      expect(id1, isNot(equals(id2)));
    });
  });
}
