class ChannelModel {
  String? chanId;
  String? chanWsId;
  String? chanName;
  String? chanCreateTime;
  String? chanLastMes;
  DateTime? chanLastMesDate;
  List? chanRead;
  String? chanSenderId;
  String? chanFile;
  String? chanCreatorId;
  String? isAvailable;

  ChannelModel(
      {this.chanId,
      this.chanWsId,
      this.chanName,
      this.chanCreateTime,
      this.chanLastMes,
      this.chanLastMesDate,
      this.chanRead,
      this.chanSenderId,
      this.isAvailable,
      this.chanFile,
      this.chanCreatorId});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    chanId = json['chan_id'];
    chanWsId = json['chan_ws_id'];
    chanName = json['chan_name'];
    chanCreateTime = json['chan_create_time'];
    chanLastMes = json['chan_last_mes'];
    chanLastMesDate = DateTime.parse(json['chan_last_mes_date']);
    chanRead = json['chan_read'].split('/');
    chanSenderId = json['chan_sender_id'];
    chanFile = json['chan_file'];
    chanCreatorId = json['chan_creator_id'];
    isAvailable = json['isAvailable'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['chan_id'] = this.chanId;
  //   data['chan_ws_id'] = this.chanWsId;
  //   data['chan_name'] = this.chanName;
  //   data['chan_create_time'] = this.chanCreateTime;
  //   data['chan_last_mes'] = this.chanLastMes;
  //   data['chan_last_mes_date'] = this.chanLastMesDate;
  //   data['chan_read'] = this.chanRead;
  //   data['isAvailable'] = this.isAvailable;
  //   return data;
  // }
}
