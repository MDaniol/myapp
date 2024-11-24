import 'package:flutter/material.dart';
import 'package:myapp/data/GetWeatherUseCase.dart';
import 'package:myapp/data/Weather.dart';

class HomeScreenStateNotifier extends ChangeNotifier {
  final GetWeatherUseCase getWeatherUseCase;

  Weather? weather;
  bool isLoading = false;

  HomeScreenStateNotifier(this.getWeatherUseCase);

  Future<void> fetchWeather() async {
    isLoading = true;
    notifyListeners();

    try {
      weather = await getWeatherUseCase();
    } catch (e) {
      // Handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}