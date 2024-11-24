import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSource({required this.client});

  Future<Map<String, dynamic>> fetchWeatherData() async {
    final response =
        await client.get(Uri.parse('https://api.example.com/weather'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
