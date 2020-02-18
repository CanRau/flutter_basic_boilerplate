part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  const ThemeState({
    @required this.themeData
  }): super();
  final ThemeData themeData;
  @override
  List<Object> get props => <ThemeData>[themeData];
}