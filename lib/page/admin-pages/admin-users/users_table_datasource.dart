import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/constants.dart';
import '../../../shared/helpers.dart';

class UsersTableDatasource extends DataTableSource {
  final List<User> users;
  final Map<String, String> columnsMap;
  final int userId;
  final Function(String button, int carId) onButtonClick;

  UsersTableDatasource({required this.users, required this.columnsMap, required this.userId, required this.onButtonClick});

  @override
  int get rowCount => users.length;

  List<int> _displayIndexToRawIndex = [];
  late List<User> sortedData;

  void setData(List<User> rawData, int sortColumn, bool sortAscending) {
    _displayIndexToRawIndex = generateIndexes(columnsMap);
    sortedData = rawData.toList()
      ..sort((User a, User b) {
        Comparable<Object> cellA;
        Comparable<Object> cellB;

        switch (_displayIndexToRawIndex[sortColumn]) {
          case 0:
            cellA = a.id.toString();
            cellB = b.id.toString();
            break;
          case 1:
            cellA = '${a.name} ${a.lastName}';
            cellB = '${b.name} ${b.lastName}';
            break;
          case 2:
            cellA = a.email ?? '';
            cellB = b.email ?? '';
            break;
          case 3:
            cellA = a.phone ?? '';
            cellB = b.phone ?? '';
            break;
          case 4:
            cellA = a.username ?? '';
            cellB = b.username ?? '';
            break;
          case 5:
            cellA = a.role?.value ?? '';
            cellB = b.role?.value ?? '';
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
        cellFor(users[index].id.toString()),
        cellFor('${users[index].name} ${users[index].lastName}'),
        cellFor(users[index].email ?? ''),
        cellFor(users[index].phone ?? ''),
        cellFor(users[index].username ?? ''),
        cellFor(users[index].role?.value ?? ''),
        DataCell(
          Padding(
            padding: Constants.tableCellPadding,
            child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, children: [
              if (userId != users[index].id!) ...[
                TextButton(
                    style: Constants.clearButtonStyle,
                    onPressed: () => onButtonClick('edit', users[index].id!),
                    child: const Icon(Icons.edit, color: AppColors.gray)),
                TextButton(
                    style: Constants.clearButtonStyle,
                    onPressed: () => onButtonClick('delete', users[index].id!),
                    child: const Icon(Icons.delete, color: AppColors.red)),
              ],
            ]),
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
