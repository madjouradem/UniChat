import '../../core/calsses/Requests.dart';

class GroupVeiwFilesData with Crud {
  getData() async {
    var response = await postRequest('AppLinks.test', {});
    return response.fold((l) => l, (r) => r);
  }
}
