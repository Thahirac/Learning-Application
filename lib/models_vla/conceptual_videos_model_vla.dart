class ConceptualVideosModelVLA {
  String ContentName,
      ContentPath,
      DisplayName,
      format,
      status,
      subject_code,
      subject_name,
      thumbnail,
      topic_id;

  ConceptualVideosModelVLA.fromJson(Map<String, dynamic> json)
      : ContentName = json['ContentName'],
        ContentPath = json['ContentPath'],
        DisplayName = json['DisplayName'],
        format = json['format'],
        status = json['status'],
        subject_code = json['subject_code'],
        subject_name = json['subject_name'],
        thumbnail = json['thumbnail'],
        topic_id = json['topic_id'];

  Map<String, dynamic> toJson() => {
        'ContentName': ContentName,
        'ContentPath': ContentPath,
        'DisplayName': DisplayName,
        'format': format,
        'status': status,
        'subject_code': subject_code,
        'subject_name': subject_name,
        'thumbnail': thumbnail,
        'topic_id': topic_id,
      };
}
