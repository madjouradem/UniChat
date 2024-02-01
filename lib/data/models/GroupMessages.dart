class GroupMessages {
  String? mesId;
  String? mesChanId;
  String? mesSenderId;
  String? mesContent;
  String? mesType;
  String? mesCreateTime;
  String? removedBy;
  String? userName;
  String? userAvatar;

  GroupMessages({
    this.mesId,
    this.mesChanId,
    this.mesSenderId,
    this.mesContent,
    this.mesType,
    this.mesCreateTime,
    this.removedBy,
    this.userName,
    this.userAvatar,
  });

  GroupMessages.fromJson(Map<String, dynamic> json) {
    mesId = json['mes_id'];
    mesChanId = json['mes_chan_id'];
    mesSenderId = json['mes_sender_id'];
    mesContent = json['mes_content'];
    mesType = json['mes_type'];
    mesCreateTime = json['mes_create_time'];
    removedBy = json['removed_by'];
    userName = json['user_name'];
    userAvatar = json['user_avatar'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['mes_id'] = mesId;
  //   data['mes_chan_id'] = mesChanId;
  //   data['mes_sender_id'] = mesSenderId;
  //   data['mes_content'] = mesContent;
  //   data['mes_type'] = mesType;
  //   data['mes_create_time'] = mesCreateTime;
  //   data['removed_by'] = removedBy;
  //   data['user_id'] = userId;
  //   data['user_name'] = userName;
  //   data['user_email'] = userEmail;
  //   data['user_password'] = userPassword;
  //   data['user_spe_id'] = userSpeId;
  //   data['user_sea_id'] = userSeaId;
  //   data['user_gro_id'] = userGroId;
  //   data['user_connId'] = userConnId;
  //   data['user_token'] = userToken;
  //   data['user_fbmToken'] = userFbmToken;
  //   data['user_avatar'] = userAvatar;
  //   data['user_status'] = userStatus;
  //   data['user_date'] = userDate;
  //   data['user_type'] = userType;
  //   data['user_isStatusOn'] = userIsStatusOn;
  //   return data;
  // }
  // String? mesId;
  // String? mesChanId;
  // String? mesSenderId;
  // String? mesContent;
  // String? mesType;
  // String? mesCreateTime;

  // GroupMessages(
  //     {this.mesId,
  //     this.mesChanId,
  //     this.mesSenderId,
  //     this.mesContent,
  //     this.mesType,
  //     this.mesCreateTime});

  // GroupMessages.fromJson(Map<String, dynamic> json) {
  //   mesId = json['mes_id'];
  //   mesChanId = json['mes_chan_id'];
  //   mesSenderId = json['mes_sender_id'];
  //   mesContent = json['mes_content'];
  //   mesType = json['mes_type'];
  //   mesCreateTime = json['mes_create_time'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['mes_id'] = this.mesId;
  //   data['mes_chan_id'] = this.mesChanId;
  //   data['mes_sender_id'] = this.mesSenderId;
  //   data['mes_content'] = this.mesContent;
  //   data['mes_type'] = this.mesType;
  //   data['mes_create_time'] = this.mesCreateTime;
  //   return data;
  // }
}
