import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/widgets/videoPlayerCtr.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key, required this.videoname});

  final String videoname;

  @override
  Widget build(BuildContext context) {
    // var ctr = Get.find<VideoPlayerCtr>(tag: widget.videoname);
    // Get.put(VideoPlayerCtr(videoname) permanent: false);
    return GetBuilder<VideoPlayerCtr>(
      init: VideoPlayerCtr(videoname),
      tag: videoname,
      builder: (ctr) {
        return FlickVideoPlayer(
          flickManager: ctr.flickManager!,
          flickVideoWithControls: FlickVideoWithControls(
            iconThemeData: IconThemeData(
              color: AppColor.primaryC1WithOpacity4,
            ),
            controls: FlickPortraitControls(
              iconSize: 22.spMin,
              progressBarSettings: FlickProgressBarSettings(
                playedColor: AppColor.primaryC1,
                backgroundColor: AppColor.primaryC1WithOpacity2,
                bufferedColor: AppColor.primaryC1WithOpacity4,
              ),
            ),
          ),
        );
      },
      autoRemove: false,
    );
  }
}
