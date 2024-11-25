import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/data/WeatherData.dart';

class WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSource({required this.client});

  Future<WeatherData> fetchWeatherData() async {
    final response =
        await client.get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,relative_humidity_2m,weather_code,surface_pressure'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
