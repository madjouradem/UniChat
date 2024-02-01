import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class EditFilesData with Crud {
  editFile(
      {required String fileId, required String name, String? nickname}) async {
    var response = await postRequest(AppLink.editFiles, {
      'file_id': fileId,
      'name': name,
      'nickname': nickname,
    });
    return response.fold((l) => l, (r) => r);
  }
}
