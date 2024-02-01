import 'dart:io';

import '../../core/calsses/Requests.dart';
import '../../core/constant/AppLinkes.dart';

class CreateWSData with Crud {
  getData() async {
    var response = await postRequest(AppLink.getSeaSpeGroups, {});
    return response.fold((l) => l, (r) => r);
  }

  addWS({
    required String wsName,
    String? wsDesc,
    String? wsImage,
    String? wsSpe,
    String? wsSea,
    String? wsGroup,
    required String wsProfId,
  }) async {
    var response = await postRequest(AppLink.addWS, {
      'ws_name': wsName,
      'ws_desc': wsDesc,
      'ws_image': wsImage,
      'ws_spe': wsSpe,
      'ws_sea': wsSea,
      'ws_group': wsGroup,
      'ws_prof_id': wsProfId
    });
    return response.fold((l) => l, (r) => r);
  }

  uploadfile(File file) async {
    var response =
        await postRequestWithFile('${AppLink.upload}upload.php', file);
    return response.fold((l) => l, (r) => r);
  }
}
