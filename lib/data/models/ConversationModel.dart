class ConversationModel {
  String? id;
  String? startedAt;
  String? user1Id;
  String? user2Id;
  String? lastMessage;
  String? messageStatus;
  DateTime? messageTime;
  String? convFile;
  String? fromId;
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

  ConversationModel(
      {this.id,
      this.startedAt,
      this.user1Id,
      this.user2Id,
      this.lastMessage,
      this.messageStatus,
      this.messageTime,
      this.convFile,
      this.fromId,
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
      this.userType});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startedAt = json['started_at'];
    user1Id = json['user1_id'];
    user2Id = json['user2_id'];
    lastMessage = json['last_message'];
    messageStatus = json['message_status'];
    messageTime = DateTime.parse(json['message_time']);
    convFile = json['conv_file'];
    fromId = json['from_id'];
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
  //   data['id'] = this.id;
  //   data['started_at'] = this.startedAt;
  //   data['user1_id'] = this.user1Id;
  //   data['user2_id'] = this.user2Id;
  //   data['last_message'] = this.lastMessage;
  //   data['message_status'] = this.messageStatus;
  //   data['from_id'] = this.fromId;
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
