import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class FoldersData with Crud {
  getData(String userId) async {
    var response = await postRequest(AppLink.foldres, {
      "user_id": userId,
    });
    return response.fold((l) => l, (r) => r);
  }

  removeFolder(folderId, folderFile) async {
    var response = await postRequest(
        AppLink.removeFolders, {'id': folderId, 'folder_file': folderFile});
    return response.fold((l) => l, (r) => r);
  }
}
