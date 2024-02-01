import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/widgets/videoPlayerCtr.dart';
import 'package:get/get.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key, required this.videoname});

  final String videoname;

  @override
  Widget build(BuildContext context) {
    // var ctr = Get.find<VideoPlayerCtr>(tag: widget.videoname);
    Get.put(VideoPlayerCtr(videoname), tag: videoname, permanent: false);
    return GetBuilder<VideoPlayerCtr>(
      builder: (ctr) {
        return Container(
            margin: const EdgeInsets.all(10),
            height: 500,
            width: 200,
            child: FlickVideoPlayer(
              flickManager: ctr.flickManager!,
            ));
      },
      tag: videoname,
      autoRemove: false,
    );
  }
}
