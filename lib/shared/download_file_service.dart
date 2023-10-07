import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;

mixin DownloadFileService {
  void _downloadFileWeb(Uint8List streamedResponseBytes, String reportName) {
    js.context.callMethod('webSaveAs', [
      html.Blob([streamedResponseBytes]),
      reportName
    ]);
  }

  Future<void> downloadFile(Uint8List streamedResponseBytes, String reportName) async {
    if (kIsWeb) {
      _downloadFileWeb(streamedResponseBytes, reportName);
    } else {
      var fileSaverPlugin = FlutterFileSaver();
      if (Platform.isIOS || Platform.isAndroid || Platform.isMacOS) {
        await fileSaverPlugin.writeFileAsBytes(fileName: reportName, bytes: streamedResponseBytes);
      } else {
        debugPrint('Unknown platform: ${Platform.operatingSystem.toString()}');
      }
    }
  }
}
