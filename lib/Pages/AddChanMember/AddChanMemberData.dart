import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class AddChanMemberData with Crud {
  getUsersIsNotInChan(String chanId, String wsId) async {
    var response = await postRequest(
        AppLink.getUsersIsNotInChan, {"chan_id": chanId, "ws_id": wsId});
    return response.fold((l) => l, (r) => r);
  }

  addMember(String chanId, List members) async {
    var response = await postRequest(
        AppLink.addmembers, {"chan_id": chanId, "members": members.toString()});
    return response.fold((l) => l, (r) => r);
  }
}
