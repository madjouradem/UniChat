import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Channels/ChannelController.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/core/calsses/webSocketConn.dart';
import 'package:flutter_chatapp/core/functions/alertWaiting.dart';
import 'package:flutter_chatapp/core/functions/showAlert.dart';
import 'package:flutter_chatapp/data/models/ChannelModel.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../../core/calsses/DownloadCtr.dart';
import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/UploadCtr.dart';
import '../../core/constant/AppRoute.dart';
import '../../core/functions/checkInternet.dart';
import '../../core/functions/crypte.dart';
import '../../core/functions/handlingData.dart';
import '../../data/models/GroupMessages.dart';
import 'GroupchatroomData.dart';
import 'package:path_provider/path_provider.dart';

abstract class GroupchatroomCtrAbs extends GetxController {
  connect();
  getMessages(); //
  sendMessage(Map data); //
  // decodeString(String? encoded);//
  // encodeString(String text);//
  pickImage(); //
  uploadImage(String chanFilePath); //
  readMessage();
  goToMoreInfo();
  onTapMessage(int val);
  removeMessageForYou(GroupMessages message);
  removeMessageForAll(GroupMessages message);
  downloadFile(String url, filename, {String? type});
  joinToChannel();
  listViewListner();
  onRecord(bool value);
  generateTempPath();
  uploadAudio(File audio);
}

class GroupchatroomCtr extends GroupchatroomCtrAbs {
  List<GroupMessages> messagesList = [];
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  StatusRequest statusRequest3 = StatusRequest.none;
  late ChannelModel channelInfo;
  final TextEditingController tctr = TextEditingController();
  WebSocketConn webConn = Get.find();
  ChannelCtr channelCtr = Get.find();
  GroupchatroomData groupchatroomdata = GroupchatroomData();
  ImagePicker imagePicker = ImagePicker();
  File file = File('');
  final dios = dio.Dio();
  String? fileName = '';
  bool isTapMess = false;
  late String id;
  int messIndex = -1;
  late String wsId;
  late String wsFile;
  ScrollController scrollController = ScrollController();
  int getMessageslength = -1;
  int maxMessageslength = 20;
  bool isRecording = false;

//===================================================================

  @override
  void onInit() {
    channelInfo = Get.arguments['channelModel'];
    wsId = Get.arguments['wsId'];
    wsFile = Get.arguments['wsFile'];
    id = myServices.box.read('user')['user_id'];
    channelCtr.chanId = id;

    listViewListner();
    connect();
    getMessages();
    readMessage();
    super.onInit();
  }

  @override
  void onClose() {
    channelCtr.chanId = '';
    print('object done');
  }

  @override
  connect() {
    print('try to lisent gg');
    webConn.strm!.listen(
      (event) {
        Map<String, dynamic> data = jsonDecode(event);
        print(data);
        data['mes_create_time'] = DateTime.now().toString();
        if (data['type'] == 'group') {
          messagesList.insert(0, GroupMessages.fromJson(data));
          if (data['mes_sender_id'] != id) {
            // if (!channelInfo.chanRead!.contains(id)) {
            if (Get.find<ChannelCtr>().chanId == channelInfo.chanId) {
              Map data1 = {
                'type': 'read_group_mess',
                'user_id': myServices.box.read('user')['user_id'],
                'chan_id': channelInfo.chanId!,
              };
              sendMessage(data1);
              for (int i = 0; i < channelCtr.channelList.length; i++) {
                if (data['chan_id'] == channelCtr.channelList[i].chanId) {
                  if (!channelCtr.channelList[i].chanRead!
                      .contains(id.toString())) {
                    channelCtr.channelList[i].chanRead!.add(id.toString());
                  }
                  break;
                }
              }
            }

            //}
          }
          print('//////////$event/////////');
        } else if (data['type'] == 'removeGroupMessage') {
          print('///////11111111111111111111///////');

          messagesList.removeWhere(
            (element) {
              return element.mesId == data['mes_id'];
            },
          );
          update();
          print('///////22222222222222222222///////');
        } else if (data['type'] == 'get_more_group_mess') {
          List messages = jsonDecode(data['messages']);
          print('messagesmessagesmessagesmessagesmessagesmessages');
          print(messages);
          messages.reversed;
          for (var element in messages) {
            messagesList.add(GroupMessages.fromJson(element));
          }
          getMessageslength = messages.length;
          update();
          messages.clear();
        }

        update();
        // HomeCtr homeCtr = Get.find();

        // for (int i = 0; i < homeCtr.conversationsList.length; i++) {
        //   if ((data['mes_from_id'] == homeCtr.conversationsList[i].user1Id ||
        //           data['mes_from_id'].toString() ==
        //               homeCtr.conversationsList[i].user2Id) &&
        //       (data['mes_to_id'].toString() ==
        //               homeCtr.conversationsList[i].user1Id ||
        //           data['mes_to_id'].toString() ==
        //               homeCtr.conversationsList[i].user2Id)) {
        //     homeCtr.conversationsList[i].messageStatus = '1';

        //     break;
        //   }

        //   // print(
        //   //     'kkkkkkkkkkkkkkkkkkkkkk${data['mes_from_id']}kkkkkkkkkkkkkkkkkkkkkkk');
        // }
      },
      onDone: () async {
        print('checkInternet and reconnect');

        if (await checkInternet()) {}
      },
    );
  }

  @override
  getMessages() async {
    // var response =
    //     await groupchatroomdata.getGroupMessages(channelInfo.chanId!, id);
    // statusRequest = handlingData(response);
    // if (statusRequest == StatusRequest.success) {
    //   if (response['status'] == 'success') {
    //     response['data'].forEach((element) {
    //       messagesList.add(GroupMessages.fromJson(element));
    //     });
    //     messagesList.reversed;

    //     print('we have Data');
    //   } else {
    //     print('we dont have Data');

    //     statusRequest = StatusRequest.failure;
    //   }
    // }
    // update();
    Map data = {
      'type': 'get_more_group_mess',
      'mes_chan_id': channelInfo.chanId,
      'user_id': id,
      'last_mess_id': '0',
    };
    sendMessage(data);
    print('get_more_group_mess');
  }

  @override
  sendMessage(Map data) {
    webConn.channel!.sink.add(jsonEncode(data));
  }

  // // sendNotifiy(String body, String title) async {
  // //   var response =
  // //       await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  // //           headers: {
  // //             'Content-Type': 'application/json',
  // //             'Authorization':
  // //                 'key=AAAAWVOPk2E:APA91bEI7LOWKM_NPKx3smUa-LX1qMXrjUmiJa-BrK3fZGEc14vjZPihdcfdNQATh2FxEABZ7c7_DKrYYAm8iGWd1bytQSMeU2v2gDK_rNuPMBLNm3PTnDkjOL4ZYb4eagAyRy8nufLL'
  // //           },
  // //           body: jsonEncode(<String, dynamic>{
  // //             'notification': <String, dynamic>{
  // //               'body': body.toString(),
  // //               'title': title.toString()
  // //             },
  // //             'priority': 'high',
  // //             'data': <String, dynamic>{
  // //               'click_action': 'FLUTTER_NOTIFICATION_CLICK'
  // //             },
  // //             'to': await FirebaseMessaging.instance.getToken()
  // //           }));
  // //   // print('post Notifiy');
  // // }

  // @override
  // encodeString(String text) {
  //   Codec<String, String> stringToBase64 = utf8.fuse(base64);
  //   String encoded = stringToBase64.encode(text);
  //   return encoded;
  // }

  // @override
  // decodeString(String? encoded) {
  //   Codec<String, String> stringToBase64 = utf8.fuse(base64);
  //   if (encoded == null) {
  //     return '';
  //   } else {
  //     String decoded = stringToBase64.decode(encoded);
  //     return decoded;
  //   }
  // }
  //  @override
  // pickImagea() async {
  //   String messageType = '';
  //   List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
  //   List<String> vedioExtensions = ['mp4'];
  //   //List<String> filesExtensions = ['pdf', 'docs'];

  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true,
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'docs', 'ppt', 'mp4'],
  //   );
  //   if (result != null) {
  //     for (int i = 0; i < result.paths.length; i++) {
  //       Map data = {};
  //       image = File(result.paths[i]!);
  //       String fileType = image.path.split('.').last;
  //       messageType = imageExtensions.contains(fileType)
  //           ? 'image'
  //           : vedioExtensions.contains(fileType)
  //               ? 'video'
  //               : 'file';

  //       fileName = await Get.put(UploadCtr()).uploadImage(
  //         File(image.path),
  //         "Conversations/$convFile",
  //       );
  //       if (fileName != '') {
  //         data = {
  //           'type': 'private',
  //           'mes_from_id': myServices.box.read('user')['user_id'],
  //           'mes_to_id': userId,
  //           'mes_content': encodeString(fileName!),
  //           'mes_type': messageType,
  //         };
  //         sendMessage(data);
  //       }
  //     }
  //   }
  // }

  @override
  pickImage() async {
    String messageType = '';
    List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
    List<String> vedioExtensions = ['mp4'];
    // List<String> filesExtensions = ['pdf', 'docs'];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'docs', 'mp4'],
    );
    if (result != null) {
      for (int i = 0; i < result.paths.length; i++) {
        Map data = {};
        file = File(result.paths[i]!);

        // print("============$wsFile/${channelInfo.chanFile}=============");
        fileName = await Get.put(UploadCtr()).uploadFile(
          File(file.path),
          {'dir': "$wsFile/${channelInfo.chanFile}"},
        );
        if (fileName != '') {
          String fileType = file.path.split('.').last;
          messageType = imageExtensions.contains(fileType)
              ? 'image'
              : vedioExtensions.contains(fileType)
                  ? 'video'
                  : 'file';
          data = {
            'type': 'group',
            'mes_sender_id': myServices.box.read('user')['user_id'],
            'mes_chan_id': channelInfo.chanId!,
            'mes_content': encodeString(fileName!),
            'mes_type': messageType,
          };
          await sendMessage(data);
        }
      }
      // result.paths.forEach((element) async {
      //   Map data = {};
      //   file = File(element!);

      //   // print("============$wsFile/${channelInfo.chanFile}=============");
      //   await uploadImage("$wsFile/${channelInfo.chanFile}");
      //   String fileType = file.path.split('.').last;
      //   messageType = imageExtensions.contains(fileType)
      //       ? 'image'
      //       : vedioExtensions.contains(fileType)
      //           ? 'video'
      //           : 'file';
      //   data = {
      //     'type': 'group',
      //     'mes_sender_id': myServices.box.read('user')['user_id'],
      //     'mes_chan_id': channelInfo.chanId!,
      //     'mes_content': encodeString(fileName),
      //     'mes_type': messageType,
      //   };
      //   await sendMessage(data);
      // });
    }
  }

  @override
  Future uploadImage(String chanFilePath) async {
    print(1);

    var response = await groupchatroomdata.uploadfile(file, chanFilePath);

    StatusRequest status = handlingData(response);
    if (StatusRequest.success == status) {
      if (response['status'] == 'success') {
        fileName = response['name'];
      }
    }
  }

  @override
  readMessage() {
    for (int i = 0; i < channelCtr.channelList.length; i++) {
      if (channelInfo == channelCtr.channelList[i]) {
        if (!channelCtr.channelList[i].chanRead!.contains(id.toString())) {
          Map data = {
            'type': 'read_group_mess',
            'user_id': myServices.box.read('user')['user_id'],
            'chan_id': channelInfo.chanId!,
          };
          sendMessage(data);
          channelCtr.channelList[i].chanRead!.add(id.toString());
        }
        break;
      }
    }
  }

  @override
  goToMoreInfo() {
    Get.toNamed(AppRoute.groupmoreInfoConv, arguments: {
      'channelModel': channelInfo,
      'wsId': wsId,
      'wsFile': wsFile
    });
  }

  @override
  onTapMessage(int val) {
    isTapMess = !isTapMess;
    if (isTapMess) {
      messIndex = val;
    } else if (!isTapMess && messIndex != val) {
      messIndex = val;
    } else {
      messIndex = -1;
    }
    update();
  }

  @override
  removeMessageForYou(GroupMessages message) async {
    var response =
        await groupchatroomdata.removeMessagesForYou(message.mesId!, id);
    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.snackbar('status', 'success');
        // if (messagesList.first.mesId == message.mesId) {
        //   for (int i = 0; i < mainCtr.conversationsList.length; i++) {
        //     if (mainCtr.conversationsList[i].id == "$userId$id" ||
        //         mainCtr.conversationsList[i].id == "$id$userId") {
        //       mainCtr.conversationsList[i].lastMessage =
        //           'WW91IHJlbW92ZWQgbWVzc2FnZQ==';
        //       mainCtr.conversationsList[i].messageTime =
        //           DateTime.parse(messagesList.last.mesCreateTime!);
        //       mainCtr.conversationsList[i].fromId =
        //           messagesList.last.mesFromId!;
        //       break;
        //     }
        //   }
        // }
        messagesList.remove(message);

        update();
      }
    }
  }

  @override
  removeMessageForAll(GroupMessages message) async {
    Map data = {
      'type': 'removeGroupMessage',
      'sender_id': id,
      'chan_id': channelInfo.chanId,
      'mes_id': message.mesId,
    };
    sendMessage(data);
  }

  @override
  downloadFile(String url, filename, {String? type}) async {
    // myServices.box.remove('downloadPaths');
    String path = await Get.put(FileCtr()).downloadAndSaveFile(url, filename);
    if (type != '') {
      List downloadPaths = myServices.box.read('downloadPaths') ?? [];
      if (!downloadPaths.contains(filename)) {
        downloadPaths.add(path);
        myServices.box.write('downloadPaths', downloadPaths);
      }
      print(downloadPaths);
    }
  }

  @override
  joinToChannel() async {
    alertWaiting();
    var response =
        await groupchatroomdata.joinTochannel(channelInfo.chanId!, id);
    statusRequest3 = handlingData(response);
    if (statusRequest3 == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.back();
        Get.back();
        channelCtr.refreshData();
      } else {
        print('we dont have Data');
        showAlert(title: 'Filure', content: 'Try again');
        statusRequest3 = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  listViewListner() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('====== we are in the last of the list');
        Future.delayed(
          const Duration(seconds: 2),
          () {
            if (getMessageslength == maxMessageslength) {
              Map data = {
                'type': 'get_more_group_mess',
                'mes_chan_id': channelInfo.chanId,
                'user_id': id,
                'last_mess_id': messagesList.last.mesId,
              };
              sendMessage(data);
              print('get_more_group_mess');
            }
          },
        );
      }
    });
  }

  @override
  onRecord(bool value) {
    isRecording = value;
    update();
  }

  @override
  Future<String> generateTempPath() async {
    Directory? dir = await getTemporaryDirectory();
    return dir.path;
  }

  @override
  uploadAudio(File audio) async {
    Get.back();
    String? fileName = '';

    fileName = await Get.put(UploadCtr())
        .uploadFile(audio, {'dir': "$wsFile/${channelInfo.chanFile}"});
    if (fileName != '') {
      Map data = {
        'type': 'group',
        'mes_sender_id': myServices.box.read('user')['user_id'],
        'mes_chan_id': channelInfo.chanId!,
        'mes_content': encodeString(fileName!),
        'mes_type': 'audio',
      };
      await sendMessage(data);
    }
  }
}
