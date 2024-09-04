import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'download_controller.dart';
import 'downloadcontroller.dart'; // Import the controller

class DownloadWidget extends StatelessWidget {
  final String fileUrl;
  final String fileName;

  DownloadWidget({
    required this.fileUrl,
    required this.fileName,
  });

  final DownloadController controller = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDownloading.value) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              value: controller.downloadProgress.value,
              strokeWidth: 6.0,
            ),
            SizedBox(height: 20),
            Text(
              '${(controller.downloadProgress.value * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 18),
            ),
          ],
        );
      } else {
        return ElevatedButton(
          onPressed: () {
            controller.downloadFile(fileUrl, fileName,"teslian");
          },
          child: Text('Download File'),
        );
      }
    });
  }
}
