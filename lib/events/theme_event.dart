import 'package:equatable/equatable.dart';
import 'package:weather_app_bloc/model/weather_model.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;
  const ThemeEventWeatherChanged({required this.weatherCondition});
  @override
  // TODO: implement props
  List<Object?> get props => [weatherCondition];
}
