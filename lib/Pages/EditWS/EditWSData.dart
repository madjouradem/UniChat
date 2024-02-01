import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class EditWSData with Crud {
  getData() async {
    var response = await postRequest(AppLink.getSeaSpeGroups, {});
    return response.fold((l) => l, (r) => r);
  }

  editWS({
    String? wsId,
    String? wsName,
    String? wsDesc,
    String? wsImage,
    String? wsSpe,
    String? wsSea,
    String? wsGroup,
  }) async {
    var response = await postRequest(AppLink.editWS, {
      'ws_id': wsId,
      'ws_name': wsName,
      'ws_desc': wsDesc,
      'ws_image': wsImage,
      'ws_spe': wsSpe,
      'ws_sea': wsSea,
      'ws_group': wsGroup,
    });
    return response.fold((l) => l, (r) => r);
  }
}
