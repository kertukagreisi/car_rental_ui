import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kDateFormat = 'MMM dd, yyyy';

extension ColorConversion on Color {
  MaterialColor toMaterialColor() {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T) operation) => operation(this);
}

extension StateExt on State {
  void doAfterBuild(FutureOr<void> Function() action) {
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (mounted) action();
    });
  }
}

extension StringCasingExt on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}

extension DateTimeExt on DateTime {
  String toDayMonthYearTimeString() {
    DateFormat dateTimeFormat = DateFormat('$kDateFormat HH:mm:ss');
    return dateTimeFormat.format(this);
  }
}
