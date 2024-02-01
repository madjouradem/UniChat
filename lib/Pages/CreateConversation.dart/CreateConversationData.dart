import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class CreateConversationData with Crud {
  getData(String? groupId, String? seaId, String? speId) async {
    var response = await postRequest(AppLink.createContact, {
      'gro_id': groupId,
      'sea_id': seaId,
      'spe_id': speId,
    });
    return response.fold((l) => l, (r) => r);
  }

  addConversation(String userid1, String userid2) async {
    var response = await postRequest(AppLink.addconversation, {
      'userid1': userid1,
      'userid2': userid2,
    });
    return response.fold((l) => l, (r) => r);
  }

  addConversationById(String userid) async {
    var response = await postRequest(AppLink.addConvById, {
      'id': userid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
