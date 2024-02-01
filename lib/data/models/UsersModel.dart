class UserModel {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userSpeId;
  String? userSeaId;
  String? userGroId;
  String? userConnId;
  String? userToken;
  String? userFbmToken;
  String? userAvatar;
  String? userStatus;
  String? userDate;
  String? userType;
  bool? isChoosed = false;

  UserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.userSpeId,
    this.userSeaId,
    this.userGroId,
    this.userConnId,
    this.userToken,
    this.userFbmToken,
    this.userAvatar,
    this.userStatus,
    this.userDate,
    this.userType,
    this.isChoosed,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userSpeId = json['user_spe_id'];
    userSeaId = json['user_sea_id'];
    userGroId = json['user_gro_id'];
    userConnId = json['user_connId'];
    userToken = json['user_token'];
    userFbmToken = json['user_fbmToken'];
    userAvatar = json['user_avatar'];
    userStatus = json['user_status'];
    userDate = json['user_date'];
    userType = json['user_type'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['user_id'] = this.userId;
  //   data['user_name'] = this.userName;
  //   data['user_email'] = this.userEmail;
  //   data['user_password'] = this.userPassword;
  //   data['user_spe_id'] = this.userSpeId;
  //   data['user_sea_id'] = this.userSeaId;
  //   data['user_gro_id'] = this.userGroId;
  //   data['user_connId'] = this.userConnId;
  //   data['user_token'] = this.userToken;
  //   data['user_fbmToken'] = this.userFbmToken;
  //   data['user_avatar'] = this.userAvatar;
  //   data['user_status'] = this.userStatus;
  //   data['user_date'] = this.userDate;
  //   data['user_type'] = this.userType;
  //   return data;
  // }
}
