import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:water_detector_app/screens/models/waterSourceModel.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<WaterSource>> fetchWaterSources() async {
    final response = await http.get(Uri.parse('$baseUrl/water-sources'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => WaterSource.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load water sources');
    }
  }
}
