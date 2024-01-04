import 'package:flutter/material.dart';
import 'package:water_detector_app/screens/services/weather_api.dart';

class WeatherUpdateWidget extends StatefulWidget {
  const WeatherUpdateWidget({super.key});

  @override
  _WeatherUpdateWidgetState createState() => _WeatherUpdateWidgetState();
}

class _WeatherUpdateWidgetState extends State<WeatherUpdateWidget> {
  late String weatherData = ''; // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    try {
      final data = await WeatherService.getWeatherData();
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weather Updates:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (weatherData.isNotEmpty) // Check if weatherData is not empty
          Text(
            weatherData,
            style: const TextStyle(fontSize: 16),
          ),
        if (weatherData.isEmpty) // Check if weatherData is empty
          Text(
            'Loading...',
            style: const TextStyle(fontSize: 16),
          ),
      ],
    );
  }
}
