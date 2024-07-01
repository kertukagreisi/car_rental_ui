import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

import '../../resources/app_colors.dart';
import '../../resources/constants.dart';

class FilePickerWidget extends StatefulWidget {
  final String label;
  final bool mandatory;
  final Function(dynamic) onChange;
  final String? toolTip;
  final bool allowMultiple;

  const FilePickerWidget({
    required this.label,
    required this.mandatory,
    required this.onChange,
    this.toolTip,
    this.allowMultiple = false,
    super.key,
  });

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  List<PlatformFile> platformFiles = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constants.filterButtonWidth,
      height: platformFiles.isNotEmpty
          ? widget.allowMultiple
              ? null
              : Constants.filePickerHeightFiles
          : Constants.filePickerHeightNoFiles,
      color: Colors.white,
      child: FormBuilderFilePicker(
        name: widget.label,
        validator: (value) => widget.mandatory && value == null ? 'Field required' : null,
        onChanged: (value) {
          print('changed');
          if (value != null && value.isNotEmpty && value.length > 1 && !widget.allowMultiple) {
            value.removeAt(0);
          } else if (value == null || value.isEmpty) {
            platformFiles = [];
          }
          setState(() {
            platformFiles = value ?? [];
            for (var platformFile in platformFiles) {
              if (platformFile.size > 3 * 1024 * 1024) {
                platformFiles.remove(platformFile);
              }
            }
          });
          widget.onChange(platformFiles);
        },
        onReset: () {
          setState(() {});
        },
        decoration: const InputDecoration(border: InputBorder.none),
        allowMultiple: widget.allowMultiple,
        customFileViewerBuilder: platformFiles.isNotEmpty ? _customFileViewerBuilder : null,
        typeSelectors: [
          TypeSelector(
            type: FileType.image,
            selector: platformFiles.isEmpty
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(color: AppColors.darkCyan, borderRadius: BorderRadius.circular(4.0)),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.cloud_upload_outlined, color: Colors.white, size: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text('Upload', style: Constants.mediumTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _customFileViewerBuilder(
    List<PlatformFile>? files,
    FormFieldSetter<List<PlatformFile>> setter,
  ) {
    files = platformFiles;
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final file = files?[index];
          return ListTile(
            title: Text(file?.name ?? '', style: Constants.mediumTextStyle.copyWith(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                files?.removeAt(index);
                setter.call([...files!]);
              },
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: AppColors.cyan.withOpacity(0.6),
        ),
        itemCount: files.length,
      ),
    );
  }
}
