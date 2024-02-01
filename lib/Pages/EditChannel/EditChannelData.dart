import 'package:flutter_chatapp/core/constant/AppLinkes.dart';

import '../../core/calsses/Requests.dart';

class EditChannelData with Crud {
  editChannel(String chanId, String chanName, String isAvailable) async {
    var response = await postRequest(AppLink.editChannel,
        {'chan_name': chanName, "chan_id": chanId, 'isAvailable': isAvailable});
    return response.fold((l) => l, (r) => r);
  }
}
