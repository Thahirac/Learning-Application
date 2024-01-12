class AssessKitModelVLA {
  String IdSubjectMaster, TopicName, IdTopicMaster;

  AssessKitModelVLA(this.IdSubjectMaster, this.TopicName, this.IdTopicMaster);

  factory AssessKitModelVLA.fromJson(Map<String, dynamic> json) {
    return AssessKitModelVLA(
        json['IdSubjectMaster'], json['TopicName'], json['_IdTopicMaster']);
  }

  Map<String, dynamic> toJson() => {
        'IdSubjectMaster': IdSubjectMaster,
        'TopicName': TopicName,
        '_IdTopicMaster': IdTopicMaster
      };
}
