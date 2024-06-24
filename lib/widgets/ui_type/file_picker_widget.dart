import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

class FilePickerWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(dynamic) onChange;
  final String? toolTip;
  final bool? allowMultiple;

  const FilePickerWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.toolTip,
    this.allowMultiple,
    super.key,
  });

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  List<PlatformFile>? platformFiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.filterButtonWidth,
      height: (platformFiles != null && (platformFiles?.isNotEmpty)!)
          ? ((widget.allowMultiple ?? true) ? null : Constants.filePickerHeightFiles)
          : Constants.filePickerHeightNoFiles,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: FormBuilderFilePicker(
              name: widget.label,
              decoration: _buildFilePickerInputDecoration(widget.label),
              validator: (value) => widget.mandatory && value == null ? 'Field required' : null,
              onChanged: (value) {
                if (value != null && value.isNotEmpty && value.length > 1 && !(widget.allowMultiple ?? false)) {
                  value.removeAt(0);
                }
                setState(() {
                  platformFiles = value;
                });
                widget.onChange(platformFiles);
              },
              onReset: () {
                setState(() {});
              },
              allowMultiple: widget.allowMultiple ?? false,
              customFileViewerBuilder: (platformFiles != null && (platformFiles?.isNotEmpty)!) ? _customFileViewerBuilder : null,
              typeSelectors: const [
                TypeSelector(
                  type: FileType.any,
                  selector: Row(
                    children: <Widget>[
                      Icon(Icons.cloud_upload_outlined),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Add documents'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildFilePickerInputDecoration(String label) {
    const outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
      borderSide: BorderSide(
        color: AppColors.darkCyan,
      ),
    );
    return InputDecoration(
      labelText: label + (widget.mandatory ? ' *' : ''),
      floatingLabelStyle: Constants.extraSmallTextStyle,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: Constants.mediumTextStyle.copyWith(
        color: Colors.black,
      ),
      errorStyle: const TextStyle(fontSize: 9, backgroundColor: AppColors.lightBlue),
      errorMaxLines: 1,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      errorBorder: outlineInputBorder,
      focusedErrorBorder: outlineInputBorder,
    );
  }

  Widget _customFileViewerBuilder(
    List<PlatformFile>? files,
    FormFieldSetter<List<PlatformFile>> setter,
  ) {
    files = platformFiles ?? [];
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final file = files?[index];
        return ListTile(
          title: Text(file?.name ?? ''),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              files?.removeAt(index);
              setter.call([...files!]);
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.darkCyan,
      ),
      itemCount: files.length,
    );
  }
}
