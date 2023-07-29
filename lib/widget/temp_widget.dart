import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/blocs/settings_bloc.dart';
import 'package:weather_app_bloc/blocs/theme_bloc.dart';
import 'package:weather_app_bloc/model/weather_model.dart';
import 'package:weather_app_bloc/state/setting_state.dart';
import 'package:weather_app_bloc/state/theme_state.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;
  const TemperatureWidget({super.key, required this.weather});

  int _toCelsius(double fahrenheit) => ((fahrenheit - 32) * 5 / 9).round();
  String _formattedTemp(double temp, TemperatureUnit unit) {
    return unit == TemperatureUnit.fahrenheit
        ? '${temp.round()}°F'
        : '${_toCelsius(temp)}°C';
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, settingsState) {
                return Column(
                  children: [
                    Text(
                      'Temp: ${_formattedTemp(weather.temp, settingsState.temperatureUnit)}',
                      style: TextStyle(color: themeState.textColor),
                    ),
                    Text(
                      'Min temp: ${_formattedTemp(weather.minTemp, settingsState.temperatureUnit)}',
                      style: TextStyle(color: themeState.textColor),
                    ),
                    Text(
                      'Max temp: ${_formattedTemp(weather.maxTemp, settingsState.temperatureUnit)}',
                      style: TextStyle(color: themeState.textColor),
                    )
                  ],
                );
              }),
            ),
          ],
        )
      ],
    );
  }
}
