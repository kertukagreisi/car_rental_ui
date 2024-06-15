import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:flutter/material.dart';

import '../../../shared/helpers.dart';

class CarTableDatasource extends DataTableSource {
  final List<Car> cars;
  final Map<String, String> columnsMap;

  CarTableDatasource({required this.cars, required this.columnsMap});

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
    return DataCell(Text(value, style: Dimens.smallTextStyle));
  }

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        cellFor(cars[index].id.toString()),
        cellFor('S${cars[index].brand}'),
        cellFor(cars[index].model),
        cellFor(cars[index].year),
        cellFor(cars[index].price),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
