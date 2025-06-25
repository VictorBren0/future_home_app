import 'package:flutter_test/flutter_test.dart';
import 'package:future_home_app/utils/calculate_scale.dart';


void main() {
  group('calculateScale', () {
    test('Retorna média correta sem clamp', () {
      final result = calculateScale([1, 2, 3]);
      expect(result, 2);
    });

    test('Arredonda corretamente', () {
      final result = calculateScale([1, 2, 3, 4]);
      expect(result, 3);
    });

    test('Limita o valor máximo em 4', () {
      final result = calculateScale([5, 6, 7]);
      expect(result, 4);
    });

    test('Limita o valor mínimo em 0', () {
      final result = calculateScale([-2, -1, 0]);
      expect(result, 0);
    });

    test('Funciona com todos os valores iguais', () {
      final result = calculateScale([3, 3, 3]);
      expect(result, 3);
    });
  });
}
