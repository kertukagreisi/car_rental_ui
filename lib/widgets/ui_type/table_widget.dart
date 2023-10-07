import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../resources/app_colors.dart';
import '../../resources/dimens.dart';

class TableWidget extends StatefulWidget {
  final String label;
  final List<String> columns;
  final bool mandatory;
  final Function(List<DataTable>?) onChange;
  final List<dynamic>? initialValue;

  const TableWidget({
    Key? key,
    required this.label,
    required this.columns,
    required this.mandatory,
    required this.onChange,
    this.initialValue,
  }) : super(key: key);

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  bool valid = false;
  late TableDataSource _tableDataSource;
  FormFieldState<dynamic>? listenToChanges;
  bool selectAll = false;
  final ValueNotifier<bool> _valueNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    valid = !(widget.mandatory);
    _tableDataSource = TableDataSource(convertToDataTablesList(widget.initialValue), widget.columns, _valueNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              widget.label,
              style: Dimens.mediumTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FormBuilderField(
                  name: widget.label,
                  validator: (value) {
                    return !valid ? 'Field required' : null;
                  },
                  onChanged: widget.onChange,
                  onReset: () {
                    setState(() {
                      _tableDataSource._dataTable = [];
                      _tableDataSource.updateDataGridRows(widget.columns);
                    });
                  },
                  builder: (FormFieldState<dynamic> field) {
                    _tableDataSource.field = field;
                    return InputDecorator(
                      decoration: const InputDecoration(),
                      child: SfDataGrid(
                        allowEditing: true,
                        source: _tableDataSource,
                        selectionMode: SelectionMode.multiple,
                        navigationMode: GridNavigationMode.cell,
                        isScrollbarAlwaysShown: true,
                        columns: _getTableColumns(),
                        editingGestureType: EditingGestureType.tap,
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        shrinkWrapRows: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<GridColumn> _getTableColumns() {
    List<GridColumn> columns = [];

    columns.add(
      GridColumn(
        columnName: 'CheckBoxes',
        width: 100.0,
        label: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          alignment: Alignment.centerLeft,
          child: ValueListenableBuilder<bool>(
            valueListenable: _valueNotifier,
            builder: (context, value, child) {
              return Checkbox(
                value: selectAll,
                onChanged: (bool? value) {
                  setState(() {
                    selectAll = value!;
                    _valueNotifier.value = value;
                  });
                },
              );
            },
          ),
        ),
        allowEditing: false,
      ),
    );

    for (var column in widget.columns) {
      columns.add(GridColumn(
        columnName: column,
        label: Container(
          width: 120,
          padding: const EdgeInsets.only(right: 20.0),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              column,
              style: Dimens.extraSmallHeadTextStyle,
            ),
          ),
        ),
      ));
    }

    columns.add(GridColumn(
      columnName: 'Actions',
      width: 120.0,
      label: Container(
        padding: const EdgeInsets.only(right: 20.0),
        alignment: Alignment.center,
        child: const Text(
          'Actions',
          style: Dimens.extraSmallHeadTextStyle,
        ),
      ),
      allowEditing: false,
    ));

    return columns;
  }

  List<DataTable> convertToDataTablesList(List<dynamic>? initialValue) {
    List<DataTable> dataTableList = [];
    if (initialValue != null) {
      for (var element in initialValue) {
        dataTableList.add(element as DataTable);
      }
    }
    return dataTableList;
  }
}

class TableDataSource extends DataGridSource {
  final List<String> _columns;

  FormFieldState<dynamic>? _field;

  List<DataTable> _dataTable = [];

  bool hasEmptyRows = true;

  bool selectAll = false;

  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);

  List<bool> checkedBoxes = [false];

  List<DataGridRow> selectedRows = [];

  List<DataGridRow> dataGridRows = [];

  set field(FormFieldState<dynamic> value) {
    _field = value;
  }

  TableDataSource(this._dataTable, this._columns, this.valueNotifier) {
    updateDataGridRows(_columns);
  }

  List<DataColumn> getDataColumns(List<String> columns) {
    List<DataColumn> dataColumnList = [];
    for (var column in columns) {
      dataColumnList.add(
        DataColumn(
          label: Text(
            column,
            style: Dimens.extraSmallTextStyle,
          ),
        ),
      );
    }
    return dataColumnList;
  }

  DataRow getDataRow(int columnsLength) {
    List<DataCell> dataCellList = [];
    for (var index = 0; index < columnsLength; index++) {
      dataCellList.add(
        const DataCell(
          Text(
            '',
            style: Dimens.extraSmallTextStyle,
          ),
        ),
      );
    }
    return DataRow(cells: dataCellList);
  }

  void updateDataGridRows(List<String> columns) {
    if (_dataTable.isEmpty) {
      //add first empty row
      _dataTable.add(DataTable(
        columns: getDataColumns(columns),
        rows: [getDataRow(columns.length)],
      ));
    }
    dataGridRows = _dataTable.map<DataGridRow>((dataGridRow) => DataGridRow(cells: getCells(dataGridRow))).toList();
    notifyListeners();
  }

  List<DataGridCell> getCells(DataTable dataTable) {
    List<DataGridCell> cells = [];
    cells.add(const DataGridCell<String>(columnName: 'checkBox', value: null));
    int index = 0;
    for (var column in _columns) {
      cells.add(DataGridCell<String>(columnName: column, value: getColumnByIndex(index, dataTable)));
      index++;
    }

    cells.add(const DataGridCell<String>(columnName: 'button', value: null));

    return cells;
  }

  void deleteDataGridRow(BuildContext context, DataGridRow row) {
    if (dataGridRows.length == 1) {
      debugPrint('There is only one row in the table. It can not be deleted!');
      return;
    }
    int index = dataGridRows.indexOf(row);

    if (index > -1) {
      selectedRows.remove(row);
      checkedBoxes.removeAt(index);
      dataGridRows.removeAt(index);
      _dataTable.removeAt(index);
    }
  }

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  String? newCellValue = '';

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          color: (dataGridRows.contains(row) && checkedBoxes[dataGridRows.indexOf(row)]) || selectAll ? AppColors.lightBlue : Colors.white,
          alignment: Alignment.centerLeft,
          child: getWidgetByColumnName(dataGridCell, row));
    }).toList());
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    final dynamic oldValue =
        dataGridRow.getCells().firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)?.value ?? '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return Future<void>(() {});
    }

    if (column.columnName != 'Actions' && column.columnName != 'CheckBoxes') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(columnName: column.columnName, value: newCellValue);

      updateDataTableBasedOnIndex(dataRowIndex, rowColumnIndex.columnIndex, newCellValue.toString());
      _field?.didChange(_dataTable);
    }
    return Future<void>(() {});
  }

  void updateDataTableBasedOnIndex(int dataRowIndex, int index, String value) {
    _dataTable[dataRowIndex].rows[0].cells[index - 1] = DataCell(
      Text(
        value,
        style: Dimens.extraSmallTextStyle,
      ),
    );
  }

  @override
  Future<bool> canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    // Return false, to retain in edit mode.
    return Future.value(true); // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText =
        dataGridRow.getCells().firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)?.value?.toString() ?? '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: TextField(
        style: Dimens.extraSmallTextStyle,
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.left,
        autocorrect: false,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: TextInputType.text,
        //autofocus: true,
        onChanged: (String value) async {
          if (value.isNotEmpty) {
            newCellValue = value;
          } else {
            newCellValue = null;
          }

          await onCellSubmit(dataGridRow, rowColumnIndex, column);
        },
        onSubmitted: (String value) {
          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  static String? getColumnByIndex(int index, DataTable dataTable) {
    return '${(dataTable.rows[0].cells[index].child as Text).data}';
  }

  Widget getWidgetByColumnName(DataGridCell dataGridCell, DataGridRow row) {
    if (dataGridCell.columnName == 'button') {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: [
            IconButton(
              onPressed: () async {
                bool hasData = true;
                for (var dataTable in _dataTable) {
                  for (var cell in dataTable.rows[0].cells) {
                    if ((cell.child as Text).data == null || (cell.child as Text).data == '') {
                      hasData = false;
                    }
                  }
                  if (!hasData) {
                    break;
                  }
                }
                if (hasData) {
                  checkedBoxes.add(false);
                  _dataTable.add(DataTable(
                    columns: getDataColumns(_columns),
                    rows: [getDataRow(_columns.length)],
                  ));
                  updateDataGridRows(_columns);
                  notifyListeners();
                } else {}
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                deleteDataGridRow(context, row);
                notifyListeners();
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        );
      });
    } else if (dataGridCell.columnName == 'checkBox') {
      return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: valueNotifier,
                builder: (context, value, child) {
                  if (value == true) {
                    selectAll = true;
                    for (int index = 0; index < checkedBoxes.length; index++) {
                      checkedBoxes[index] = true;
                    }
                  } else {
                    if (selectAll == true) {
                      for (int index = 0; index < checkedBoxes.length; index++) {
                        checkedBoxes[index] = false;
                      }
                    }
                    selectAll = false;
                  }
                  return Checkbox(
                    value: checkedBoxes[dataGridRows.indexOf(row)],
                    onChanged: (value) {
                      checkedBoxes[dataGridRows.indexOf(row)] = !checkedBoxes[dataGridRows.indexOf(row)];
                      if (value == true) {
                        selectedRows.add(row);
                      } else {
                        selectedRows.remove(row);
                      }
                      notifyListeners();
                    },
                  );
                },
              ),
            ),
          ],
        );
      });
    } else {
      return Text(
        dataGridCell.value.toString(),
        overflow: TextOverflow.ellipsis,
        style: Dimens.extraSmallTextStyle,
      );
    }
  }
}
