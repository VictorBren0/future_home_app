import 'package:flutter_test/flutter_test.dart';
import 'package:future_home_app/services/weather_service.dart';

void main() {
  final service = WeatherService();

  test('Deve retornar um mapa ou null', () async {
    final data = await service.getLocationInfo();
    expect(data, anyOf([isNull, isA<Map<String, dynamic>>()]));
  });

  test('Deve retornar double ou null', () async {
    final temp = await service.getCurrentTemperature(-23.55, -46.63); // São Paulo
    expect(temp, anyOf([isNull, isA<double>()]));
  });
}
