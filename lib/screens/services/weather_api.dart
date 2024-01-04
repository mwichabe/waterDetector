import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String apiKey = 'c0b04fef36fb219046797c08b6f8f82b';
  static const String city = 'Solapur';

  static Future<String> getWeatherData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final weatherDescription = data['weather'][0]['description'];
      return 'Weather: $weatherDescription';
    } else {
      return 'Failed to fetch weather data';
    }
  }
}
