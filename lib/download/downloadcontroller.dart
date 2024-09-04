import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadController extends GetxController {
  var downloadProgress = 0.0.obs;
  var isDownloading = false.obs;
  var downloadedFiles = <File>[].obs;
  var ongoingDownloads = <String, double>{}.obs;

  Dio _dio = Dio();

  Future<void> downloadFile(String url, String fileName, String folderName) async {
    // Request storage permission
    await requestStoragePermission();

    try {
      isDownloading.value = true;

      // Get the path to the "Download" directory
      Directory? downloadDir;
      if (Platform.isAndroid) {
        downloadDir = Directory('/storage/emulated/0/Download/$folderName');
      } else if (Platform.isIOS) {
        downloadDir = await getApplicationDocumentsDirectory(); // iOS sandboxed directory
        downloadDir = Directory('${downloadDir.path}/$folderName');
      }

      if (downloadDir != null && !(await downloadDir.exists())) {
        // Create the folder if it does not exist
        await downloadDir.create(recursive: true);
      }

      String savePath = "${downloadDir!.path}/$fileName";

      ongoingDownloads[fileName] = 0.0;

      // Start the file download
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            ongoingDownloads[fileName] = progress;
            downloadProgress.value = progress;
          }
        },
      );

      isDownloading.value = false;
      ongoingDownloads.remove(fileName);

      File downloadedFile = File(savePath);
      downloadedFiles.add(downloadedFile);

      Get.snackbar('Success', 'File downloaded successfully!');
    } catch (e) {
      isDownloading.value = false;
      ongoingDownloads.remove(fileName);
      Get.snackbar('Error', 'Failed to download file: $e');
    }
  }

  Future<void> requestStoragePermission() async {
    if (await Permission.storage.isGranted) {
      return;
    } else {
      await Permission.storage.request();
    }

    if (Platform.isAndroid && await Permission.storage.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    if (await Permission.storage.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
