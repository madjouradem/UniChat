import 'package:flutter_chatapp/core/constant/AppLinkes.dart';
import '../../core/calsses/Requests.dart';

class CreateChannelData with Crud {
  addChannel(String wsId, String chanName, String userId, String wsFile,
      List members) async {
    var response = await postRequest(AppLink.addChannel, {
      'chan_name': chanName,
      'user_id': userId,
      "ws_id": wsId,
      "ws_file": wsFile,
      'members': members.isNotEmpty ? members.toString() : 'null'
    });
    return response.fold((l) => l, (r) => r);
  }

  getWsUsers(String wsId) async {
    var response = await postRequest(AppLink.getWsUsers, {"ws_id": wsId});
    return response.fold((l) => l, (r) => r);
  }
}
