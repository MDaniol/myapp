import 'package:myapp/data/Weather.dart';
import 'package:myapp/data/WeatherRepository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<Weather> call() async {
    return await repository.getWeather();
  }
}