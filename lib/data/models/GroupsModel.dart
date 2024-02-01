class GroupsModel {
  String? groId;
  String? groName;

  GroupsModel({this.groId, this.groName});

  GroupsModel.fromJson(Map<String, dynamic> json) {
    groId = json['gro_id'];
    groName = json['gro_name'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['gro_id'] = this.groId;
  //   data['gro_name'] = this.groName;
  //   return data;
  // }
}
