class AfterAfterAssessKitModelVLA {
  String ContentName, ContentPath, Content_ID, DisplayName, IdTopicMaster;

  AfterAfterAssessKitModelVLA(this.ContentName, this.ContentPath,
      this.Content_ID, this.DisplayName, this.IdTopicMaster);

  factory AfterAfterAssessKitModelVLA.fromJson(Map<String, dynamic> json) {
    return AfterAfterAssessKitModelVLA(
        json['ContentName'],
        json['ContentPath'],
        json['Content_ID'],
        json['DisplayName'],
        json['IdTopicMaster']
    );
  }

  Map<String, dynamic> toJson() => {
        'ContentName': ContentName,
        'ContentPath': ContentPath,
        'Content_ID': Content_ID,
        'DisplayName': DisplayName,
        'IdTopicMaster': IdTopicMaster
      };
}
