import 'package:flutter/material.dart';

class TextStyleTheme extends InheritedWidget {
  final TextThemeMy theme;

  const TextStyleTheme({required this.theme, Key? key, required Widget child})
      : super(key: key, child: child);

  static TextThemeMy of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<TextStyleTheme>();
    assert(result != null, 'No');
    return result!.theme;
  }

  @override
  bool updateShouldNotify(TextStyleTheme oldWidget) => theme != oldWidget.theme;
}

class TextThemeMy {
  Color textColor;
  Color background;
  Color appBar;
  double fontSizeDescriptionWeather;

  TextThemeMy(
      {required this.background,
      required this.appBar,
      required this.textColor,
      required this.fontSizeDescriptionWeather});

  void setTheme(Color textColorNew, Color backgroundNew, Color appBarNew,
      double fontSizeDescriptionWeatherNew) {
    textColor = textColorNew;
    background = backgroundNew;
    appBar = appBarNew;
    fontSizeDescriptionWeather = fontSizeDescriptionWeatherNew;
  }
}
