class FoldersModel {
  String? folderId;
  String? folderName;
  String? folderCutName;
  String? folderFile;
  String? folderOwner;
  String? folderCreateTime;
  String? folderSpeId;
  String? folderSeaId;
  String? folderIsHiding;

  FoldersModel(
      {this.folderId,
      this.folderName,
      this.folderCutName,
      this.folderFile,
      this.folderOwner,
      this.folderCreateTime,
      this.folderSpeId,
      this.folderSeaId,
      this.folderIsHiding});

  FoldersModel.fromJson(Map<String, dynamic> json) {
    folderId = json['folder_id'];
    folderName = json['folder_name'];
    folderCutName = json['folder_cut_name'];
    folderFile = json['folder_file'];
    folderOwner = json['folder_owner'];
    folderCreateTime = json['folder_create_time'];
    folderSpeId = json['folder_spe_id'];
    folderSeaId = json['folder_sea_id'];
    folderIsHiding = json['folder_is_hiding'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['folder_id'] = this.folderId;
  //   data['folder_name'] = this.folderName;
  //   data['folder_cut_name'] = this.folderCutName;
  //   data['folder_owner'] = this.folderOwner;
  //   data['folder_create_time'] = this.folderCreateTime;
  //   data['folder_spe_id'] = this.folderSpeId;
  //   data['folder_sea_id'] = this.folderSeaId;
  //   data['folder_is_hiding'] = this.folderIsHiding;
  //   return data;
  // }
}
