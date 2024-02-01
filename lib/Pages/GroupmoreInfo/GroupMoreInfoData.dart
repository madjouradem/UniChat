import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class GroupMoreInfoData with Crud {
  deleteChannel(String chanId, String chanFile) async {
    var response = await postRequest(
        AppLink.deleteChannel, {"chan_id": chanId, 'chan_file': chanFile});
    return response.fold((l) => l, (r) => r);
  }
}
