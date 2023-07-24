import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/blocs/settings_bloc.dart';
import 'package:weather_app_bloc/events/setting_event.dart';
import 'package:weather_app_bloc/state/setting_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
            return ListTile(
              title: const Text('Temperature Unit'),
              subtitle: Text(
                  settingsState.temperatureUnit == TemperatureUnit.celsius
                      ? 'Celsius'
                      : 'Fahrenheit'),
              trailing: Switch(
                value: settingsState.temperatureUnit == TemperatureUnit.celsius,
                onChanged: (_) => BlocProvider.of<SettingsBloc>(context)
                    .add(SettingEventToggleUnit()),
              ),
            );
          })
        ],
      ),
    );
  }
}
