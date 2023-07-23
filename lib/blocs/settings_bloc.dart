import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/events/setting_event.dart';
import 'package:weather_app_bloc/state/setting_state.dart';

class SettingsBloc extends Bloc<SettingEvent, SettingsState> {
  //initial state
  SettingsBloc()
      : super(const SettingsState(temperatureUnit: TemperatureUnit.celsius));

  Stream<SettingsState> mapEventToState(SettingEvent settingEvent) async* {
    if (settingEvent is SettingEventToggleUnit) {
      yield SettingsState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius);
    }
  }
}