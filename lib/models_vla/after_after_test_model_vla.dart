class AfterAfterTestModelVLA {
  String concept,
      ContentPath,
      Content_ID,
      FileName,
      Session_id,
      Status,
      Subject_id;

  AfterAfterTestModelVLA(this.concept, this.ContentPath, this.Content_ID,
      this.FileName, this.Session_id, this.Status, this.Subject_id);

  factory AfterAfterTestModelVLA.fromJson(Map<String, dynamic> json) {
    return AfterAfterTestModelVLA(
        json['concept'],
        json['ContentPath'],
        json['Content_ID'],
        json['FileName'],
        json['Session_id'],
        json['Status'],
        json['Subject_id']);
  }

  Map<String, dynamic> toJson() => {
        'concept': concept,
        'ContentPath': ContentPath,
        'Content_ID': Content_ID,
        'FileName': FileName,
        'Session_id': Session_id,
        'Status': Status,
        'Subject_id': Subject_id

      };
}
