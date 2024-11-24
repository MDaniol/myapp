import 'package:flutter/material.dart';
import 'package:myapp/data/Recommendations.dart';
import 'package:myapp/data/Weather.dart';

class HomeScreenContent extends StatelessWidget {
  final EdgeInsets innerPadding;
  final Function(String) onNavigate;
  final HomeScreenState uiState;

  const HomeScreenContent({
    Key? key,
    required this.innerPadding,
    required this.onNavigate,
    required this.uiState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: innerPadding,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onNavigate("details/1"),
            child: Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                height: 240,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Today's weather",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        uiState.weatherSummary,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          WeatherInfoItem(
                            icon: Icons.wb_sunny,
                            label: "Clearance",
                            value: uiState.weather.clearance,
                          ),
                          WeatherInfoItem(
                            icon: Icons.thermostat,
                            label: "Temperature",
                            value: uiState.weather.temperature,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          WeatherInfoItem(
                            icon: Icons.water_drop,
                            label: "Humidity",
                            value: uiState.weather.humidity,
                          ),
                          WeatherInfoItem(
                            icon: Icons.speed,
                            label: "Pressure",
                            value: uiState.weather.pressure,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your caregiver's recommendations",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  RecommendationItem(
                    icon: Icons.medical_services,
                    title: "Effects on your medicines",
                    body: uiState.recommendations.effectsOnMedicines,
                  ),
                  RecommendationItem(
                    icon: Icons.sentiment_satisfied,
                    title: "How can you feel",
                    body: uiState.recommendations.howCanYouFeel,
                  ),
                  RecommendationItem(
                    icon: Icons.health_and_safety,
                    title: "Recommendations",
                    body: uiState.recommendations.recommendations,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfoItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecommendationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const RecommendationItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class HomeScreenState {
  final String weatherSummary;
  final Weather weather;
  final Recommendations recommendations;

  HomeScreenState({
    required this.weatherSummary,
    required this.weather,
    required this.recommendations,
  });

  // Static property for a default instance
  static final HomeScreenState defaultState = HomeScreenState(
    weatherSummary: "Sunny with mild temperatures expected throughout the day.",
    weather: Weather(
      clearance: "Clear",
      temperature: "25°C",
      humidity: "50%",
      pressure: "1013 hPa",
    ),
    recommendations: Recommendations(
      effectsOnMedicines:
          "No significant interactions expected with your current medications.",
      howCanYouFeel:
          "You might feel slightly more energetic due to the pleasant weather.",
      recommendations: "Stay hydrated and consider a light outdoor walk.",
    ),
  );
}

