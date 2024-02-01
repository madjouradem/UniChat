import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/calsses/AudioPlayerCtr.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/constant/AppImage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';

class AudioRecorderWidget extends StatelessWidget {
  const AudioRecorderWidget({
    super.key,
    required this.path,
    required this.onSend,
  });

  final String path;
  final void Function(File?) onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      height: 55.spMin,
      // width: 50,
      // padding: const EdgeInsets.only(top: 5),
      // color: Colors.amber,
      child: Center(
        child: Builder(builder: (context) {
          return SocialMediaRecorder(
            storeSoundRecoringPath: path,
            backGroundColor: Colors.transparent,
            recordIcon: SvgPicture.asset(AppImage.microphone),
            sendRequestFunction: (soundFile) {
              showModalBottomSheet(
                enableDrag: true,
                elevation: 4,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.spMin),
                    topRight: Radius.circular(10.spMin),
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return GetBuilder<AudioPlayerCtr>(
                      autoRemove: true,
                      init: AudioPlayerCtr(soundFile.path, isLocal: true),
                      tag: soundFile.path,
                      builder: (ctr) {
                        return SizedBox(
                          height: 80.spMin,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.highlight_remove)),
                              Expanded(
                                child: Container(
                                  height: 50.spMin,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryC1WithOpacity2,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (ctr.isPlaying) {
                                              ctr.audioPlayer.pause();
                                            } else {
                                              ctr.audioPlayer.resume();
                                            }
                                          },
                                          icon: Icon(ctr.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow)),
                                      Expanded(
                                        child: Slider(
                                          min: 0.0,
                                          activeColor: AppColor.primaryC1,
                                          max:
                                              ctr.duration.inSeconds.toDouble(),
                                          onChanged: (value) async {
                                            ctr.position = Duration(
                                                seconds: value.toInt());
                                            await ctr.audioPlayer
                                                .seek(ctr.position);
                                            ctr.update();
                                          },
                                          value:
                                              ctr.position.inSeconds.toDouble(),
                                        ),
                                      ),
                                      Text(ctr.formatTime(ctr.position)),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    onSend(soundFile);
                                  },
                                  icon: const Icon(Icons.send)),
                            ],
                          ),
                        );
                      });
                },
              );
            },
            encode: AudioEncoderType.AAC,
          );
        }),
      ),
    );
  }
}
