// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:get/get.dart';
// import 'package:torrent_streamer/torrent_streamer.dart';
//
// class TorrentStreamerController extends GetxController {
//   var isStreamReady = false.obs;
//   var progress = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _addTorrentListeners();
//     TorrentStreamer.init();
//   }
//
//   void _addTorrentListeners() {
//     TorrentStreamer.addEventListener('progress', (data) {
//       progress.value = data['progress'];
//     });
//
//     TorrentStreamer.addEventListener('ready', (_) {
//       isStreamReady.value = true;
//     });
//   }
//
//   Future<void> startDownload(String torrentLink) async {
//     await TorrentStreamer.start(torrentLink);
//   }
//
//   Future<void> openVideo() async {
//     if (progress.value == 100) {
//       await TorrentStreamer.launchVideo();
//     } else {
//       Get.defaultDialog(
//         title: 'Are You Sure?',
//         middleText: 'Playing video while it is still downloading is experimental and only works on a limited set of apps.',
//         confirm: TextButton(
//           onPressed: () async {
//             await TorrentStreamer.launchVideo();
//             Get.back();
//           },
//           child: Text('Yes, Proceed'),
//         ),
//         cancel: TextButton(
//           onPressed: () => Get.back(),
//           child: Text('Cancel'),
//         ),
//       );
//     }
//   }
// }
//
// class VideoPlayerController extends GetxController {
//   late YoutubePlayerController youtubeController;
//   var isFullScreen = false.obs;
//
//   VideoPlayerController(String videoId) {
//     youtubeController = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//       ),
//     )..addListener(_listener);
//   }
//
//   void _listener() {
//     if (youtubeController.value.isFullScreen) {
//       isFullScreen.value = true;
//     } else {
//       isFullScreen.value = false;
//     }
//   }
//
//   @override
//   void onClose() {
//     youtubeController.dispose();
//     super.onClose();
//   }
// }
