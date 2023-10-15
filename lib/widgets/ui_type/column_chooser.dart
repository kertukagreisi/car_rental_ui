import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:flutter/material.dart';

class ColumnChooser extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSubmit;
  final List<String> selectedItems;

  const ColumnChooser({Key? key, required this.items, required this.onSubmit, required this.selectedItems}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColumnChooserState();
}

class _ColumnChooserState extends State<ColumnChooser> {
// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selectedItems.add(itemValue);
      } else {
        widget.selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    if (widget.selectedItems.isEmpty) {
      showSnackBar(SnackBarLevel.warning, 'You need to select at least a column!');
      return;
    }
    Navigator.pop(context, widget.selectedItems);
    widget.onSubmit.call(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(minWidth: 300.0),
          child: ListBody(
            children: widget.items
                .map((item) => CheckboxListTile(
                      value: widget.selectedItems.contains(item),
                      title: Text(item),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (isChecked) => _itemChange(item, isChecked!),
                    ))
                .toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
