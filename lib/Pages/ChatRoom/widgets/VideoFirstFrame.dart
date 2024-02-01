import 'package:flutter_chatapp/core/constant/AppLinkes.dart';
import 'package:get/get.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

class VideoFirstFrameCtr extends GetxController {
  final String videoname;

  var fileName;

  VideoFirstFrameCtr(this.videoname);
  firstFrame() async {
    fileName = await VideoThumbnail.thumbnailFile(
      video: "${AppLink.upload}$videoname",
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      // maxHeight:
      //     64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    update();
  }

  @override
  void onInit() {
    super.onInit();
    firstFrame();
  }
}
