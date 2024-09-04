import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  if (await Permission.storage.isGranted) {
    // Storage permission is already granted
  } else {
    // Request storage permission
    await Permission.storage.request();
  }

  // If targeting Android 11 or higher, you may also need to request Manage External Storage permission
  if (Platform.isAndroid && await Permission.storage.isDenied) {
    await Permission.manageExternalStorage.request();
  }

  if (await Permission.storage.isPermanentlyDenied) {
    // Open app settings if permission is permanently denied
    await openAppSettings();
  }
}
