import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';

class BookingTableDatasource extends DataTableSource {
  final List<Booking> bookings;

  BookingTableDatasource({required this.bookings});

  @override
  int get rowCount => bookings.length;

  static const List<int> _displayIndexToRawIndex = <int>[0, 1, 2, 3, 4];
  late List<Booking> sortedData;

  void setData(List<Booking> rawData, int sortColumn, bool sortAscending) {
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
      value = '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
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
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
