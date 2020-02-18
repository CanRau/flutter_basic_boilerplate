part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({@required this.theme}): super();
  final AppTheme theme;

  @override
  List<Object> get props => <AppTheme>[theme];
}