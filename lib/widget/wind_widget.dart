import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/blocs/theme_bloc.dart';
import 'package:weather_app_bloc/model/weather_model.dart';
import 'package:weather_app_bloc/state/theme_state.dart';

class WindWidget extends StatelessWidget {
  final Weather weather;
  const WindWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = BlocProvider.of<ThemeBloc>(context).state;
    return SizedBox(
      child: Column(
        children: [
          Text(
            'WindSpeed',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeState.textColor),
          ),
          Row(
            children: [
              Image.asset('assets/imgs/wind.png'),
              Text(
                '${weather.windSpeed}',
                style: TextStyle(color: themeState.textColor, fontSize: 16),
              )
            ],
          )
        ],
      ),
    );
  }
}
