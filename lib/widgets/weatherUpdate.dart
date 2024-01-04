import 'package:flutter/material.dart';
import 'package:water_detector_app/screens/services/weather_api.dart';

class WeatherUpdateWidget extends StatefulWidget {
  const WeatherUpdateWidget({super.key});

  @override
  _WeatherUpdateWidgetState createState() => _WeatherUpdateWidgetState();
}

class _WeatherUpdateWidgetState extends State<WeatherUpdateWidget> {
  late String weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      weatherData = await WeatherService.getWeatherData();
      setState(() {});
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
        Text(
          weatherData,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
