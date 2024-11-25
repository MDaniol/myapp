// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:myapp/UI/HomePage.dart';
import 'package:myapp/UI/HomeScreenStateNotifier.dart';
import 'package:myapp/data/GetWeatherUseCase.dart';
import 'package:myapp/data/Recommendations.dart';
import 'package:myapp/data/WeatherRemoteDataSource.dart';
import 'package:myapp/data/WeatherRepository.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  final client = http.Client();
  final dataSource = WeatherRemoteDataSource(client: client);
  final repository = WeatherRepositoryImpl(remoteDataSource: dataSource);
  final useCase = GetWeatherUseCase(repository);

  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeScreenStateNotifier(useCase),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final stateNotifier =
        Provider.of<HomeScreenStateNotifier>(context, listen: false);
    stateNotifier.fetchWeather(); // Automatically fetch weather data
  }

  @override
  Widget build(BuildContext context) {
    final stateNotifier = Provider.of<HomeScreenStateNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Cardio Weather")),
      body: stateNotifier.isLoading
          ? Center(child: CircularProgressIndicator())
          : stateNotifier.weather != null
              ? HomeScreenContent(
                  innerPadding: const EdgeInsets.all(16),
                  onNavigate: (route) => Navigator.pushNamed(context, route),
                  uiState: HomeScreenState(
                    weatherSummary: "Today's weather is great!",
                    weather: stateNotifier.weather!,
                    recommendations: Recommendations(
                      effectsOnMedicines: "No concerns.",
                      howCanYouFeel: "Energetic.",
                      recommendations: "Enjoy outdoor activities.",
                    ),
                  ),
                )
              : Center(child: Text("Failed to load weather data.")),
    );
  }
}
