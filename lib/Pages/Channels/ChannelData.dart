import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class ChannelData with Crud {
  getDataForStudent(String wsId, String userId) async {
    var response = await postRequest(
        AppLink.channelForStudent, {'ws_id': wsId, 'user_id': userId});
    return response.fold((l) => l, (r) => r);
  }

  // getDataForProfs(String wsId) async {
  //   var response = await postRequest(AppLink.channelForProf, {'ws_id': wsId});
  //   return response.fold((l) => l, (r) => r);
  // }

  verifiyJoin(String chanId, String userId) async {
    var response = await postRequest(AppLink.verifiyJoiningInChannel,
        {'chan_id': chanId, 'user_id': userId});
    return response.fold((l) => l, (r) => r);
  }
}
