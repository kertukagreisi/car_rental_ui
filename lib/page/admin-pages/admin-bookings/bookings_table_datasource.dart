import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/helpers.dart';
import 'package:flutter/material.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/dimens.dart';

class BookingsTableDatasource extends DataTableSource {
  final List<Booking> bookings;
  final Map<String, String> columnsMap;
  final Function(String button, int bookingId) onButtonClick;

  BookingsTableDatasource({required this.bookings, required this.columnsMap, required this.onButtonClick});

  @override
  int get rowCount => bookings.length;

  List<int> _displayIndexToRawIndex = [];
  late List<Booking> sortedData;

  void setData(List<Booking> rawData, int sortColumn, bool sortAscending) {
    _displayIndexToRawIndex = generateIndexes(columnsMap);
    sortedData = rawData.toList()
      ..sort((Booking a, Booking b) {
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
            cellA = a.startDate;
            cellB = b.startDate;
            break;
          case 3:
            cellA = a.endDate;
            cellB = b.endDate;
            break;
          case 4:
            cellA = a.bookingStatus.value;
            cellB = b.bookingStatus.value;
            break;
          case 5:
            cellA = a.total;
            cellB = b.total;
            break;
          case 6:
            cellA = a.timeStamp;
            cellB = b.timeStamp;
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
        cellFor(bookings[index].id.toString()),
        cellFor('${bookings[index].name} ${bookings[index].lastName}'),
        cellFor(bookings[index].startDate),
        cellFor(bookings[index].endDate),
        cellFor(bookings[index].bookingStatus.value),
        cellFor(bookings[index].total),
        cellFor(bookings[index].timeStamp),
        DataCell(Padding(
          padding: Dimens.tableCellPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (bookings[index].bookingStatus == BookingStatus.PENDING || bookings[index].bookingStatus == BookingStatus.ACTIVE) ...[
                TextButton(
                    onPressed: () => onButtonClick('approve', bookings[index].id!),
                    style: Dimens.clearButtonStyle,
                    child: const Icon(Icons.done_all, color: AppColors.green)),
                TextButton(
                    onPressed: () => onButtonClick('reject', bookings[index].id!),
                    style: Dimens.clearButtonStyle,
                    child: const Icon(Icons.cancel_outlined, color: AppColors.darkGray)),
              ],
              TextButton(
                  onPressed: () => onButtonClick('delete', bookings[index].id!),
                  style: Dimens.clearButtonStyle,
                  child: const Icon(Icons.delete, color: AppColors.red)),
            ],
          ),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
