class WorkspaceModel {
  String? wsId;
  String? wsName;
  String? wsDesc;
  String? wsImage;
  String? wsFile;
  String? wsGroId;
  String? wsSeaId;
  String? wsSpeId;
  String? wsProfId;

  WorkspaceModel(
      {this.wsId,
      this.wsName,
      this.wsImage,
      this.wsFile,
      this.wsDesc,
      this.wsGroId,
      this.wsSeaId,
      this.wsSpeId,
      this.wsProfId});

  WorkspaceModel.fromJson(Map<String, dynamic> json) {
    wsId = json['ws_id'];
    wsName = json['ws_name'];
    wsDesc = json['ws_desc'];
    wsImage = json['ws_image'];
    wsFile = json['ws_file'];
    wsGroId = json['ws_gro_id'];
    wsSeaId = json['ws_sea_id'];
    wsSpeId = json['ws_spe_id'];
    wsProfId = json['ws_prof_id'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['ws_id'] = this.wsId;
  //   data['ws_name'] = this.wsName;
  //   data['ws_gro_id'] = this.wsGroId;
  //   data['ws_sea_id'] = this.wsSeaId;
  //   data['ws_spe_id'] = this.wsSpeId;
  //   data['ws_prof_id'] = this.wsProfId;
  //   return data;
  // }
}
