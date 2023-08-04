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

  int _toCelsius(double kelvin) => (kelvin - 273.5).round();
  int _toFahrenheit(double kelvin) => ((kelvin - 273.5) * 9 / 5 + 32).round();
  String _formattedTemp(double temp, TemperatureUnit unit) {
    return unit == TemperatureUnit.fahrenheit
        ? '${_toFahrenheit(temp)}°F'
        : '${_toCelsius(temp)}°C';
  }

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
            return SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Temperature',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: themeState.textColor),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                'assets/imgs/temp1.png',
                                fit: BoxFit.fill,
                              )),
                          Text(
                            '${_formattedTemp(weather.temp, settingsState.temperatureUnit)}',
                            style: TextStyle(
                                color: themeState.textColor, fontSize: 25),
                          ),
                        ],
                      ),
                      Text(
                        'Min: ${_formattedTemp(weather.minTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(color: themeState.textColor),
                      ),
                      Text(
                        'Max: ${_formattedTemp(weather.maxTemp, settingsState.temperatureUnit)}',
                        style: TextStyle(color: themeState.textColor),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'WindSpeed',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: themeState.textColor),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 35,
                              width: 35,
                              child: Image.asset(
                                'assets/imgs/wind.png',
                                fit: BoxFit.fill,
                              )),
                          Text(
                            '${weather.windSpeed}',
                            style: TextStyle(
                                color: themeState.textColor, fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        'Humidity',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: themeState.textColor),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 35,
                              width: 40,
                              child: Image.asset(
                                'assets/imgs/humidity.png',
                                fit: BoxFit.fill,
                              )),
                          Text(
                            '${weather.humidity}%',
                            style: TextStyle(
                                color: themeState.textColor, fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}
