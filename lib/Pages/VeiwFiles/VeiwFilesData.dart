import '../../core/calsses/Requests.dart';

class VeiwFilesData with Crud {
  getData() async {
    var response = await postRequest('AppLinks.test', {});
    return response.fold((l) => l, (r) => r);
  }
}
