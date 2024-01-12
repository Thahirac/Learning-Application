class AfterAfterTestModelPDFVLA {
  String? contentId;
  String? concept;
  String? sessionId;
  String? contentPath;
  String? fileName;
  String? classId;
  String? status;

  AfterAfterTestModelPDFVLA({
    this.contentId,
    this.concept,
    this.sessionId,
    this.contentPath,
    this.fileName,
    this.classId,
    this.status,
  });

  factory AfterAfterTestModelPDFVLA.fromJson(Map<String, dynamic> json) => AfterAfterTestModelPDFVLA(
    contentId: json["Content_ID"],
    concept: json["concept"],
    sessionId: json["Session_id"],
    contentPath: json["ContentPath"],
    fileName: json["FileName"],
    classId: json["Class_id"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Content_ID": contentId,
    "concept": concept,
    "Session_id": sessionId,
    "ContentPath": contentPath,
    "FileName": fileName,
    "Class_id": classId,
    "Status": status,
  };
}
