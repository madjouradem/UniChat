import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class AddFoldersData with Crud {
  addFolder(
      {required String userId,
      required String name,
      String? nickname,
      String? speId,
      String? seaId}) async {
    var response = await postRequest(AppLink.addFoldres, {
      'user_id': userId,
      'name': name,
      'nickname': nickname,
      'sea_id': seaId,
      'spe_id': speId,
    });
    return response.fold((l) => l, (r) => r);
  }

  getData() async {
    var response = await postRequest(AppLink.getSeaSpeGroups, {});
    return response.fold((l) => l, (r) => r);
  }
}
