import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class MainData with Crud {
  //create Contact page
  getDataForStudents(
      String groupId, String seaId, String speId, String id) async {
    var response = await postRequest(AppLink.homeS,
        {'gro_id': groupId, 'sea_id': seaId, 'spe_id': speId, 'id': id});
    return response.fold((l) => l, (r) => r);
  }

//create Contact page
  getDataForProfs(String spofId) async {
    var response = await postRequest(AppLink.homeP, {
      'prof_id': spofId,
    });
    return response.fold((l) => l, (r) => r);
  }

  insertDatainWsmember(String userId, String wsId) async {
    var response = await postRequest(AppLink.wsMembers, {
      'user_id': userId,
      'ws_id': wsId,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateConversation(String convId) async {
    var response = await postRequest(AppLink.updateconversation, {
      'conv_id': convId,
    });
    return response.fold((l) => l, (r) => r);
  }

  createWorkspace() async {
    var response = await postRequest(AppLink.wsMembers, {});
    return response.fold((l) => l, (r) => r);
  }

  deleteWorkspace(String wsId, String wsFile) async {
    var response = await postRequest(
        AppLink.deleteWS, {"ws_id": wsId, "ws_file_name": wsFile});
    return response.fold((l) => l, (r) => r);
  }
}
