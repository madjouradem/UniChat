import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_chatapp/core/constant/AppLinkes.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerCtr extends GetxController {
  FlickManager? flickManager;
  final String videoname;

  VideoPlayerCtr(this.videoname);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        '${AppLink.upload}$videoname',
      ),
      autoPlay: false,
    );
    // print('////////////////////////#@!$videoname///////////////');

    // update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    flickManager!.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager!.dispose();
  }
}
