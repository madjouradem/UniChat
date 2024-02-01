class SpecialtyModel {
  String? speId;
  String? speName;

  SpecialtyModel({this.speId, this.speName});

  SpecialtyModel.fromJson(Map<String, dynamic> json) {
    speId = json['spe_id'];
    speName = json['spe_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['spe_id'] = this.speId;
  //   data['spe_name'] = this.speName;
  //   return data;
  // }
}
