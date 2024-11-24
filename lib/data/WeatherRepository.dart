import 'package:myapp/data/Weather.dart';
import 'package:myapp/data/WeatherRemoteDataSource.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather();
}

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Weather> getWeather() async {
    final data = await remoteDataSource.fetchWeatherData();
    return Weather(
      clearance: data['clearance'],
      temperature: data['temperature'],
      humidity: data['humidity'],
      pressure: data['pressure'],
    );
  }
}

class MockWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> getWeather() async {
    await Future.delayed(const Duration(seconds: 5)); // Simulates network delay
    return Weather(
      clearance: "`Cloudy`",
      temperature: "26°C",
      humidity: "45%",
      pressure: "1012 hPa",
    );
  }
}
