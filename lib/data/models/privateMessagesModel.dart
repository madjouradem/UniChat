class privateMessagesModel {
  String? mesId;
  String? mesConvId;
  String? mesFromId;
  String? mesToId;
  String? mesContent;
  String? mesType;
  String? mesCreateTime;
  String? removedBy;
  String? userName;
  String? userAvatar;

  privateMessagesModel(
      {this.mesId,
      this.mesConvId,
      this.mesFromId,
      this.mesToId,
      this.mesContent,
      this.mesType,
      this.mesCreateTime,
      this.removedBy,
      this.userName,
      this.userAvatar});

  privateMessagesModel.fromJson(Map<String, dynamic> json) {
    mesId = json['mes_id'];
    mesConvId = json['mes_conv_id'];
    mesFromId = json['mes_from_id'];
    mesToId = json['mes_to_id'];
    mesContent = json['mes_content'];
    mesType = json['mes_type'];
    mesCreateTime = json['mes_create_time'];
    removedBy = json['removed_by'];
    userName = json['user_name'];
    userAvatar = json['user_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mes_id'] = mesId;
    data['mes_conv_id'] = mesConvId;
    data['mes_from_id'] = mesFromId;
    data['mes_to_id'] = mesToId;
    data['mes_content'] = mesContent;
    data['mes_type'] = mesType;
    data['mes_create_time'] = mesCreateTime;
    data['removed_by'] = removedBy;
    data['user_name'] = userName;
    data['user_avatar'] = userAvatar;
    return data;
  }
}
