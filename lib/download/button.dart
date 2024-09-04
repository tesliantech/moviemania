import 'package:flutter/material.dart';
import 'package:moviepie/download/ui.dart';
// import 'download_controller.dart'; // Import the controller
import 'package:get/get.dart';

import 'downloadcontroller.dart';

class DownloadButton extends StatelessWidget {
  final String fileUrl;
  final String fileName;

  DownloadButton({
    required this.fileUrl,
    required this.fileName,
  });

  final DownloadController controller = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.bottomSheet(
          DownloadWidget(fileUrl: fileUrl, fileName: fileName),
          backgroundColor: Colors.white,
          isScrollControlled: true,
        );
      },
      child: Text('Download File'),
    );
  }
}


// DownloadButton(
// fileUrl: 'https://example.com/yourfile.zip',
// fileName: 'downloadedfile.zip',
// ),
