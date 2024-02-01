import 'dart:io';

import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class GroupchatroomData with Crud {
  getData(String wsId, String profId) async {
    var response = await postRequest(
        AppLink.channelForStudent, {'ws_id': wsId, 'prof_id': profId});
    return response.fold((l) => l, (r) => r);
  }

  getGroupMessages(String chanId, String id) async {
    var response = await postRequest(
        AppLink.groupMessages, {'chan_id': chanId, 'user_id': id});
    return response.fold((l) => l, (r) => r);
  }

  uploadfile(File file, String path) async {
    var response = await postRequestWithFile(
        '${AppLink.upload}upload.php', file,
        data: {'dir': path});
    return response.fold((l) => l, (r) => r);
  }

  removeMessagesForYou(String messageId, String userId) async {
    var response = await postRequest(AppLink.removeGroupMessageForYou,
        {'mes_id': messageId, 'user_id': userId});
    return response.fold((l) => l, (r) => r);
  }

  joinTochannel(String chanId, String userId) async {
    var response =
        await postRequest(AppLink.join, {'chan_id': chanId, 'user_id': userId});
    return response.fold((l) => l, (r) => r);
  }
}
