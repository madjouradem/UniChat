import 'package:flutter_chatapp/core/constant/AppLinkes.dart';

import '../../core/calsses/Requests.dart';

class LoginData with Crud {
  getData(String email, String password, List data) async {
    var response = await postRequest(AppLink.login, {
      'email': email,
      'password': password,
      'list': data.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
