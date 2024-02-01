class SeasonModel {
  String? seaId;
  String? seaName;

  SeasonModel({this.seaId, this.seaName});

  SeasonModel.fromJson(Map<String, dynamic> json) {
    seaId = json['sea_id'];
    seaName = json['sea_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['sea_id'] = this.seaId;
  //   data['sea_name'] = this.seaName;
  //   return data;
  // }
}
