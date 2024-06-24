import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:car_rental_ui/generated_code/lib/api.dart' as api_values;
import '../resources/constants.dart';

String getErrorMessage(Object? error) {
  return error.toString().substring(error.toString().indexOf(':') + 2, error.toString().length);
}

String convertToCamelCase(String input) {
  if (input.isEmpty) return input;
  List<String> words = input.split(RegExp(r'[_\s]+'));
  if (words.isEmpty) return input;

  String camelCaseString = '';

  for (int index = 0; index < words.length; index++) {
    String word = words[index];
    if (word.isNotEmpty) {
      camelCaseString += '${word.substring(0, 1).toUpperCase()}${word.substring(1, word.length).toLowerCase()}';
    }
  }
  return camelCaseString;
}

Color getTextColor(bool isMainColor, String value) {
  if (isMainColor) {
    switch (value) {
      case 'BEIGE':
        return const Color(0xFF542031);
      case 'BLACK':
        return Colors.black;
      case 'CHROME':
        return Colors.black45;
      case 'GRAY':
        return Colors.black12;
      case 'GREEN':
        return Colors.green;
      case 'RED':
        return AppColors.darkRed;
      case 'YELLOW':
        return Colors.yellow;
      case 'WHITE':
        return Colors.white;
      default:
        return AppColors.darkCyan;
    }
  } else {
    switch (value) {
      case 'BEIGE':
        return Colors.white;
      case 'BLACK':
        return Colors.white;
      case 'CHROME':
        return Colors.white;
      case 'GRAY':
        return Colors.white;
      case 'GREEN':
        return Colors.white;
      case 'RED':
        return Colors.white;
      case 'YELLOW':
        return AppColors.darkCyan;
      case 'WHITE':
        return AppColors.darkCyan;
      default:
        return Colors.white;
    }
  }
}

List<DataColumn> getColumns(Map<String, String> columnsMap) {
  return columnsMap.entries
      .map((column) =>
          DataColumn(label: Text(column.value, style: Constants.smallTextStyle.copyWith(fontWeight: FontWeight.w600)), tooltip: column.value))
      .toList();
}

List<int> generateIndexes(Map<String, String> map) {
  return List<int>.generate(map.length + 1, (index) => index);
}

List<String> roleValues = api_values.Role.values.map((role) => role.value).toList();
List<String> brandValues = api_values.Brand.values.map((brand) => brand.value).toList();
List<String> fuelTypeValues = api_values.FuelType.values.map((fuelType) => fuelType.value).toList();
List<String> colorValues = api_values.Color.values.map((color) => color.value).toList();
List<String> transmissionValues = api_values.Transmission.values.map((transmission) => transmission.value).toList();

List<String> noAuthRoutes = [NavRoute.home.path, NavRoute.carDetails.path];
List<String> adminRoutes = [NavRoute.adminCars.path, NavRoute.adminUsers.path, NavRoute.adminBookings.path];
