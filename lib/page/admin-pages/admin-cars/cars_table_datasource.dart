import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/constants.dart';
import 'package:flutter/material.dart';

import '../../../shared/helpers.dart';

class CarsTableDatasource extends DataTableSource {
  final List<Car> cars;
  final Map<String, String> columnsMap;
  final Function(String button, int carId) onButtonClick;

  CarsTableDatasource({required this.cars, required this.columnsMap, required this.onButtonClick});

  @override
  int get rowCount => cars.length;

  List<int> _displayIndexToRawIndex = [];
  late List<Car> sortedData;

  void setData(List<Car> rawData, int sortColumn, bool sortAscending) {
    _displayIndexToRawIndex = generateIndexes(columnsMap);
    sortedData = rawData.toList()
      ..sort((Car a, Car b) {
        Comparable<Object> cellA;
        Comparable<Object> cellB;

        switch (_displayIndexToRawIndex[sortColumn]) {
          case 0:
            cellA = a.id.toString();
            cellB = b.id.toString();
            break;
          case 1:
            cellA = a.brand.value;
            cellB = b.brand.value;
            break;
          case 2:
            cellA = a.model;
            cellB = b.model;
            break;
          case 3:
            cellA = a.year;
            cellB = b.year;
            break;
          case 4:
            cellA = a.price;
            cellB = b.price;
            break;
          default:
            throw Exception('Invalid sort column');
        }

        return cellA.compareTo(cellB) * (sortAscending ? 1 : -1);
      });
    notifyListeners();
  }

  static DataCell cellFor(Object data) {
    String value;
    if (data is DateTime) {
      value = '${data.day}.${data.month.toString().padLeft(2, '0')}.${data.year.toString().padLeft(2, '0')}';
    } else {
      value = data.toString();
    }
    return DataCell(Text(value, style: Constants.smallTextStyle));
  }

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        cellFor(cars[index].id.toString()),
        cellFor(cars[index].brand.value),
        cellFor(cars[index].model),
        cellFor(cars[index].year),
        cellFor(cars[index].price),
        DataCell(
          Padding(
            padding: Constants.tableCellPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    style: Constants.clearButtonStyle,
                    onPressed: () => onButtonClick('edit', cars[index].id!),
                    child: const Icon(Icons.edit, color: AppColors.gray)),
                TextButton(
                    style: Constants.clearButtonStyle,
                    onPressed: () => onButtonClick('delete', cars[index].id!),
                    child: const Icon(Icons.delete, color: AppColors.red)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
