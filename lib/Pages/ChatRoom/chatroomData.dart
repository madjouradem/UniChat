import 'dart:io';

import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class ChatroomData with Crud {
  getData(String wsId, String profId) async {
    var response = await postRequest(
        AppLink.channelForStudent, {'ws_id': wsId, 'prof_id': profId});
    return response.fold((l) => l, (r) => r);
  }

  getPrivateMessages(String id1, String convId) async {
    var response = await postRequest(
        AppLink.privateMessages, {'from_id': id1, 'conv_id': convId});
    return response.fold((l) => l, (r) => r);
  }

  uploadfile(File file, String path) async {
    var response = await postRequestWithFile(
      '${AppLink.upload}upload.php',
      file,
      data: {
        'dir': "Conversations/$path",
      },
    );

    return response.fold((l) => l, (r) => r);
  }

  removeMessagesForYou(String messageId, String userId) async {
    var response = await postRequest(
        AppLink.removeMessageForYou, {'mes_id': messageId, 'user_id': userId});
    return response.fold((l) => l, (r) => r);
  }

  removeMessagesForAll(String messageId) async {
    var response =
        await postRequest(AppLink.removeMessageForAll, {'mes_id': messageId});
    return response.fold((l) => l, (r) => r);
  }
}
