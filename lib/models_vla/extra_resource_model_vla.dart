class ExtraResourceModelVLA {
  String? conceptName;
  String? contentPath;
  String? filename;
  String? format;
  String? idParent;
  String? classId;
  String? status;

  ExtraResourceModelVLA(
      {this.conceptName,
        this.contentPath,
        this.filename,
        this.format,
        this.idParent,
        this.classId,
        this.status});

  ExtraResourceModelVLA.fromJson(Map<String, dynamic> json) {
    conceptName = json['concept_name'];
    contentPath = json['ContentPath'];
    filename = json['filename'];
    format = json['format'];
    idParent = json['id_parent'];
    classId = json['class_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['concept_name'] = this.conceptName;
    data['ContentPath'] = this.contentPath;
    data['filename'] = this.filename;
    data['format'] = this.format;
    data['id_parent'] = this.idParent;
    data['class_id'] = this.classId;
    data['status'] = this.status;
    return data;
  }
}
