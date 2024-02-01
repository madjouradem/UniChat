import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/chatroomData.dart';
import 'package:flutter_chatapp/Pages/Main/mainController.dart';
import 'package:flutter_chatapp/core/calsses/DownloadCtr.dart';
import 'package:flutter_chatapp/core/calsses/UploadCtr.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/core/calsses/webSocketConn.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/constant/AppRoute.dart';
import '../../core/functions/checkInternet.dart';
import '../../core/functions/handlingData.dart';
import '../../data/models/privateMessagesModel.dart';
import 'package:path_provider/path_provider.dart';

abstract class ChatroomCtrAbs extends GetxController {
  connect();
  getMessages();
  sendMessage(Map data);
  decodeString(String? encoded);
  encodeString(String text);
  pickImage();
  // uploadImage();
  readMessage2();
  onTapMessage(int val);
  goToMoreInfo();
  removeMessageForYou(privateMessagesModel message);
  removeMessageForAll(privateMessagesModel message);
  downloadFile(String url, filename);
  listViewListner();
  onRecord(bool value);
  generateTempPath();
  uploadAudio(File audio);
}

class ChatroomCtr extends ChatroomCtrAbs {
  List<privateMessagesModel> messagesList = [];

  late String userId;
  late String userName;
  String? userImage;
  String convFile = '';
  String convId = '';
  MyServices myServices = Get.find();
  MainCtr mainCtr = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  StatusRequest statusRequest3 = StatusRequest.none;
  final TextEditingController tctr = TextEditingController();
  WebSocketConn webConn = Get.find();
  ChatroomData chatroomdata = ChatroomData();
  ImagePicker imagePicker = ImagePicker();
  File image = File('');
  late String id;
  bool isTapMess = false;
  int messIndex = -1;
  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey textButton = GlobalKey();
  final dios = dio.Dio();
  ScrollController scrollController = ScrollController();
  int getMessageslength = -1;
  int maxMessageslength = 20;
  bool isRecording = false;

//===================================================================
  @override
  void onInit() {
    userId = Get.arguments['userId'];
    userName = Get.arguments['userName'];
    convId = Get.arguments['convId'];
    userImage = Get.arguments['userImage'];
    convFile = Get.arguments['convFile'];
    id = myServices.box.read('user')['user_id'];

    listViewListner();
    connect();
    getMessages();
    readMessage2();
    super.onInit();
  }

  @override
  void onClose() {
    mainCtr.update();
    mainCtr.userId = '';
  }

  @override
  connect() {
    2.delay();
    webConn.strm!.listen(
      (event) async {
        Map<String, dynamic> data = jsonDecode(event);
        data['mes_create_time'] = DateTime.now().toString();
        if (data['type'] == 'private') {
          messagesList.insert(0, privateMessagesModel.fromJson(data));
          //for sort conversation
          for (int i = 0; i < mainCtr.conversationsList.length; i++) {
            if ('${data['mes_from_id']}${data['mes_to_id']}' ==
                    mainCtr.conversationsList[i].id ||
                '${data['mes_to_id']}${data['mes_from_id']}' ==
                    mainCtr.conversationsList[i].id) {
              if (mainCtr.userId == userId) {
                mainCtr.conversationsList[i].messageStatus = '1';
              } else {
                mainCtr.conversationsList[i].messageStatus = '0';
              }
              mainCtr.conversationsList[i].messageTime = DateTime.now();
              mainCtr.conversationsList[i].fromId = data['mes_from_id'];
              mainCtr.conversationsList[i].lastMessage = data['mes_content'];

              // mainCtr.update();
              break;
            }
          }
          mainCtr.conversationsList
              .sort((a, b) => b.messageTime!.compareTo(a.messageTime!));

          update();
          if (data['mes_from_id'] != myServices.box.read('user')['user_id']) {
            Map data = {
              'type': 'read_private_mess',
              'mes_from_id': userId,
              'mes_to_id': id
            };
            sendMessage(data);
          }
        } else if (data['type'] == 'removePrivateMessage') {
          messagesList.removeWhere(
            (element) {
              return element.mesId == data['mes_id'];
            },
          );
          update();
        } else if (data['type'] == 'get_more_private_mess') {
          List messages = jsonDecode(data['messages']);
          messages.reversed;
          for (var element in messages) {
            messagesList.add(privateMessagesModel.fromJson(element));
          }
          getMessageslength = messages.length;
          update();
          messages.clear();
        }
      },
      onDone: () async {
        if (await checkInternet()) {}
      },
    );
  }

  @override
  getMessages() async {
    // var response = await chatroomdata.getPrivateMessages(
    //   userId,
    //   convId,
    // );
    // statusRequest = handlingData(response);
    // if (statusRequest == StatusRequest.success) {
    //   if (response['status'] == 'success') {
    //     response['data'].forEach((element) {
    //       messagesList.add(privateMessagesModel.fromJson(element));
    //     });
    //     messagesList.reversed;
    //     getMessageslength = messagesList.length;
    //     print('we have Data');
    //   } else {
    //     print('we dont have Data');
    //     statusRequest = StatusRequest.failure;
    //   }
    // }
    // update();
    Map data = {
      'type': 'get_more_private_mess',
      'mes_to_id': userId, //
      'mes_conv_id': convId,
      'last_mess_id': 0,
    };
    sendMessage(data);
    print('object/////');
  }

  @override
  sendMessage(Map data) {
    webConn.channel!.sink.add(jsonEncode(data));
  }

  @override
  encodeString(String text) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(text);
    return encoded;
  }

  @override
  decodeString(String? encoded) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    if (encoded == null) {
      return '';
    } else {
      String decoded = stringToBase64.decode(encoded);
      return decoded;
    }
  }

  String? fileName = '';

  @override
  pickImage() async {
    String messageType = '';
    List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
    List<String> vedioExtensions = ['mp4'];
    //List<String> filesExtensions = ['pdf', 'docs'];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'docs', 'ppt', 'mp4'],
    );
    if (result != null) {
      for (int i = 0; i < result.paths.length; i++) {
        Map data = {};
        image = File(result.paths[i]!);
        String fileType = image.path.split('.').last;
        messageType = imageExtensions.contains(fileType)
            ? 'image'
            : vedioExtensions.contains(fileType)
                ? 'video'
                : 'file';

        fileName = await Get.put(UploadCtr())
            .uploadFile(File(image.path), {'dir': "Conversations/$convFile"});
        if (fileName != '') {
          data = {
            'type': 'private',
            'mes_conv_id': convId,
            'mes_from_id': myServices.box.read('user')['user_id'],
            'mes_to_id': userId,
            'mes_content': encodeString(fileName!),
            'mes_type': messageType,
          };
          sendMessage(data);
        }
      }
    }
  }

  @override
  readMessage2() async {
    for (int i = 0; i < mainCtr.conversationsList.length; i++) {
      if (mainCtr.conversationsList[i].id == '$userId$id' &&
              mainCtr.conversationsList[i].userId ==
                  mainCtr.conversationsList[i].fromId &&
              mainCtr.conversationsList[i].messageStatus == '0' ||
          mainCtr.conversationsList[i].id == '$id$userId' &&
              mainCtr.conversationsList[i].userId ==
                  mainCtr.conversationsList[i].fromId &&
              mainCtr.conversationsList[i].messageStatus == '0') {
        Map data = {
          'type': 'read_private_mess',
          'mes_from_id': userId,
          'mes_to_id': id
        };
        sendMessage(data);
        mainCtr.conversationsList[i].messageStatus = '1';
        break;
      }
    }

    // for (int i = 0; i < mainCtr.conversationsList.length; i++) {
    //   if (channelInfo == channelCtr.channelList[i]) {
    //     if (!channelCtr.channelList[i].chanRead!.contains(id.toString())) {
    //       Map data = {
    //         'type': 'read_group_mess',
    //         'user_id': myServices.box.read('user')['user_id'],
    //         'chan_id': channelInfo.chanId!,
    //       };
    //       sendMessage(data);
    //       channelCtr.channelList[i].chanRead!.add(id.toString());
    //     }
    //     break;
    //   }
    // }
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
  goToMoreInfo() {
    Get.toNamed(AppRoute.moreInfoConv,
        arguments: {'userName': userName, 'userImage': userImage});
  }

  @override
  removeMessageForYou(privateMessagesModel message) async {
    var response = await chatroomdata.removeMessagesForYou(message.mesId!, id);
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
        mainCtr.update();
        update();
      }
    }
  }

  @override
  removeMessageForAll(privateMessagesModel message) async {
    Map data = {
      'type': 'removePrivateMessage',
      'from_id': id,
      'to_id': userId,
      'mes_id': message.mesId,
    };
    sendMessage(data);
    // var response = await chatroomdata.removeMessagesForAll(message.mesId!);
    // statusRequest3 = handlingData(response);
    // if (statusRequest3 == StatusRequest.success) {
    //   if (response['status'] == 'success') {
    //     Get.snackbar('status', 'success');
    //     messagesList.remove(message);

    //       // print(messagesList.last.mesId == message.mesId);
    //       // if (messagesList.first.mesId == message.mesId) {
    //       //   for (int i = 0; i < mainCtr.conversationsList.length; i++) {
    //       //     if (mainCtr.conversationsList[i].id == "$userId$id" ||
    //       //         mainCtr.conversationsList[i].id == "$id$userId") {
    //       //       mainCtr.conversationsList[i].lastMessage =
    //       //           'WW91IHJlbW92ZWQgbWVzc2FnZQ==';
    //       //       mainCtr.conversationsList[i].messageTime = DateTime.now();
    //       //       break;
    //       //     }
    //       //   }
    //       // }

    //       // mainCtr.update();
    //       update();
    //     }
    //   }
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
  listViewListner() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            if (getMessageslength >= maxMessageslength) {
              Map data = {
                'type': 'get_more_private_mess',
                'mes_to_id': userId, //
                'mes_conv_id': convId,
                'last_mess_id': messagesList.last.mesId,
              };
              sendMessage(data);
              print('get_more_private_mess');
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
        .uploadFile(audio, {'dir': "Conversations/$convFile"});
    if (fileName != '') {
      Map data = {
        'type': 'private',
        'mes_conv_id': convId,
        'mes_from_id': myServices.box.read('user')['user_id'],
        'mes_to_id': userId,
        'mes_content': encodeString(fileName!),
        'mes_type': 'audio',
      };
      sendMessage(data);
    }
  }
}
