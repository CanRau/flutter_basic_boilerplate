import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() {
    _loadSharedPrefs();
  }

  @override
  ThemeState get initialState =>
      ThemeState(themeData: appThemeData[AppTheme.greenDark]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      yield ThemeState(themeData: appThemeData[event.theme]);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // print('event.theme');
      // print('${event.theme.hashCode}');
      // print('${event.theme.index}');
      // print('${event.theme.toString()}');
      // print('event.theme');
      prefs.setInt('theme', event.theme.index);
    }
  }

  Future<void> _loadSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int themeIndex = prefs.get('theme') as int;
    if (themeIndex != null) {
      add(ThemeChanged(theme: AppTheme.values[themeIndex]));
    }
  }
}
