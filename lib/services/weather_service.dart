import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>?> getLocationInfo() async {
    const url = 'http://www.geoplugin.net/json.gp';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<double?> getCurrentTemperature(double lat, double lon) async {
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['current']['temperature_2m']?.toDouble();
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
