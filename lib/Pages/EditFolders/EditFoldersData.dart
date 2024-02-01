import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class EditFoldersData with Crud {
  editFolder(
      {required String folderId,
      required String name,
      String? nickname,
      String? speId,
      String? seaId}) async {
    var response = await postRequest(AppLink.editFoldres, {
      'folder_id': folderId,
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
