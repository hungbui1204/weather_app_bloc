import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/events/theme_event.dart';
import 'package:weather_app_bloc/model/weather_model.dart';
import 'package:weather_app_bloc/state/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //init state
  ThemeBloc()
      : super(const ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white)) {
    on<ThemeEventWeatherChanged>((themeEvent, emit) {
      ThemeState newThemeState;
      final weatherCondition = themeEvent.weatherCondition;
      if (weatherCondition == WeatherCondition.clear) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.yellow, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.clouds) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.grey, textColor: Colors.black);
      } else if (weatherCondition == WeatherCondition.rain ||
          weatherCondition == WeatherCondition.drizzle) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.indigo, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.snow ||
          weatherCondition == WeatherCondition.dust ||
          weatherCondition == WeatherCondition.ash ||
          weatherCondition == WeatherCondition.fog ||
          weatherCondition == WeatherCondition.mist ||
          weatherCondition == WeatherCondition.haze ||
          weatherCondition == WeatherCondition.sand ||
          weatherCondition == WeatherCondition.smoke ||
          weatherCondition == WeatherCondition.squall) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.lightBlue, textColor: Colors.white);
      } else if (weatherCondition == WeatherCondition.thunderstorm ||
          weatherCondition == WeatherCondition.tornado) {
        newThemeState = const ThemeState(
            backgroundColor: Colors.deepPurple, textColor: Colors.white);
      } else {
        newThemeState = const ThemeState(
            backgroundColor: Colors.blueAccent, textColor: Colors.white);
      }
      return emit(newThemeState);
    });
  }
}
