import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/widgets/VideoPlayerWidget.dart';
import 'package:get/get.dart';

class ShowVideo extends StatelessWidget {
  const ShowVideo({super.key});

  @override
  Widget build(BuildContext context) {
    String videoName = Get.arguments['videoName'];
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayerWidget(videoname: videoName),
    ));
  }
}
