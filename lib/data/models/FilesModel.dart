class FilesModel {
  String? fileId;
  String? fileName;
  String? fileCutName;
  String? fileContent;
  String? fileCreateTime;
  String? fileLibId;
  String? folderFile;

  FilesModel(
      {this.fileId,
      this.fileName,
      this.fileCutName,
      this.fileContent,
      this.fileCreateTime,
      this.fileLibId,
      this.folderFile});

  FilesModel.fromJson(Map<String, dynamic> json) {
    fileId = json['file_id'];
    fileName = json['file_name'];
    fileCutName = json['file_cut_name'];
    fileContent = json['file_content'];
    fileCreateTime = json['file_create_time'];
    fileLibId = json['file_lib_id'];
    folderFile = json['folder_file'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['file_id'] = this.fileId;
  //   data['file_name'] = this.fileName;
  //   data['file_cut_name'] = this.fileCutName;
  //   data['file_content'] = this.fileContent;
  //   data['file_create_time'] = this.fileCreateTime;
  //   data['file_lib_id'] = this.fileLibId;
  //   return data;
  // }
}
