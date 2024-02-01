import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_chatapp/core/calsses/Requests.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/core/constant/AppLinkes.dart';
import 'package:flutter_chatapp/core/functions/checkInternet.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

class WebSocketConn extends GetxController with Crud {
  late String token;
  IOWebSocketChannel? channel;
  Stream<dynamic>? strm;
  late Map responsebody;
  MyServices myServices = Get.find();
  String doneReason = '';

  Future<bool> initWebSocket() async {
    try {
      token = generateRandomString(32);
      await Future.doWhile(() async {
        await Future.delayed(const Duration(seconds: 4));

        if (await checkInternet()) {
          responsebody = await updateToken();
          return false;
        } else {
          Get.snackbar('ALERT', 'CHCKE INTERNET');

          return true;
        }
      });
      if (responsebody['status'] == 'success') {
        channel =
            IOWebSocketChannel.connect('ws://10.0.2.2:8080/?token=$token');
        strm = channel!.stream.asBroadcastStream();
        if (strm != null) {
          strm!.listen(
            (event) {},
            onDone: () async {
              if (doneReason == '') {
                await Future.doWhile(() async {
                  await Future.delayed(const Duration(seconds: 4));
                  if (await checkInternet()) {
                    if (await initWebSocket() == true) {
                      return false;
                    } else {
                      return true;
                    }
                  } else {
                    Get.snackbar('ALERT', 'CHCKE INTERNET');
                    return true;
                  }
                });
              }
            },
          );
        }
      } else {
        if (doneReason == '') {
          initWebSocket();
        }
      }
      return true;
    } on SocketException catch (e) {
      print(e.message);
      return false;
    }
  }

  updateToken() async {
    var response = await http.post(Uri.parse(AppLink.updatetokenandStatus),
        body: {'token': token, 'id': myServices.box.read('user')['user_id']});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  sendMessage(Map data) {
    channel!.sink.add(jsonEncode(data));
  }
}
