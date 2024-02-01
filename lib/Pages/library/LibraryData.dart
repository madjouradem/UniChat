import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class LibraryData with Crud {
  getData(String search, String isFiles) async {
    var response = await postRequest(
        AppLink.search, {"search": search, "isFiles": isFiles});
    return response.fold((l) => l, (r) => r);
  }

  getgetSeaSpeGroups() async {
    var response = await postRequest(AppLink.getSeaSpeGroups, {});
    return response.fold((l) => l, (r) => r);
  }

  filter(String speId, String seaId) async {
    var response =
        await postRequest(AppLink.filter, {"spe_id": speId, "sea_id": seaId});
    return response.fold((l) => l, (r) => r);
  }
}
