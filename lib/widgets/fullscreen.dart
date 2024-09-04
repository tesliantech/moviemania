import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:get/get.dart';

class FullscreenController extends GetxController {
  var isFullScreen = false.obs;
}

class FullscreenVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final FullscreenController controller = Get.put(FullscreenController());

  FullscreenVideoPlayer({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fullscreen Video Player'),
      ),
      body: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              onReady: () {
                controller.isFullScreen.value = youtubeController.value.isFullScreen;
              },
              bottomActions: [
                CurrentPosition(),
                SizedBox(width: 10),
                ProgressBar(isExpanded: true),
                SizedBox(width: 10),
                RemainingDuration(),
                FullScreenButton(),
              ],
            ),
          ),
          Obx(() {
            return controller.isFullScreen.value
                ? ElevatedButton(
              onPressed: () {
                youtubeController.toggleFullScreenMode();
                controller.isFullScreen.value = !controller.isFullScreen.value;
              },
              child: const Text('Exit Full Screen'),
            )
                : ElevatedButton(
              onPressed: () {
                youtubeController.toggleFullScreenMode();
                controller.isFullScreen.value = !controller.isFullScreen.value;
              },
              child: const Text('Enter Full Screen'),
            );
          }),
        ],
      ),
    );
  }
}
