import 'package:flutter/material.dart';
import 'package:moviepie/widgets/youtubecontroller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'torrent_streamer_controller.dart';

class TorrentStreamerView extends StatelessWidget {
  final TorrentStreamerController controller = Get.put(TorrentStreamerController());

  final String torrentLink;

  TorrentStreamerView({required this.torrentLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Torrent Streamer'),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text('Start Download'),
                onPressed: () => controller.startDownload(torrentLink),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                child: Text('Play Video'),
                onPressed: () => controller.openVideo(),
              ),
              SizedBox(height: 16),
              if (controller.progress.value > 0)
                Text('Download Progress: ${controller.progress.value}%'),
              if (controller.isStreamReady.value)
                Text('Stream is ready to play!'),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        );
      }),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;
  final VideoPlayerController controller;

  VideoPlayerWidget({required this.videoUrl}) : controller = Get.put(VideoPlayerController(YoutubePlayer.convertUrlToId(videoUrl)!));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Video Player'),
        ),
        body: Column(
          children: [
            YoutubePlayer(
              controller: controller.youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    controller.youtubeController.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  onPressed: () {
                    // log('Settings Tapped!');
                  },
                ),
              ],
              onReady: () {},
              // onFullScreen: (isFullScreen) {
              //   controller.isFullScreen.value = isFullScreen;
              // },
              onEnded: (data) {
                // Handle video end
              },
            ),
            if (controller.isFullScreen.value)
              ElevatedButton(
                onPressed: () {
                  // controller.youtubeController.exitFullScreen();
                },
                child: const Text('Exit Full Screen'),
              ),
            ElevatedButton(
              onPressed: () {
                if (controller.isFullScreen.value) {
                  // controller.youtubeController.exitFullScreen();
                } else {
                  // controller.youtubeController.enterFullScreen();
                }
              },
              child: const Text('Toggle Full Screen'),
            ),
          ],
        ),
      );
    });
  }
}
