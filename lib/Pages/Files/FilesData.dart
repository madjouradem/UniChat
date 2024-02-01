import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class FilesData with Crud {
  getData(folderId) async {
    var response = await postRequest(AppLink.files, {'folder_id': folderId});
    return response.fold((l) => l, (r) => r);
  }

  removeFile(fileId, fileFile) async {
    var response = await postRequest(
        AppLink.removeFiles, {'id': fileId, 'file_file': fileFile});
    return response.fold((l) => l, (r) => r);
  }
}
