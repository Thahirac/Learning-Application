class WhatsNewModelVLA {
  String classname,
      Class_id = "",
      concept,
      duration,
      filename,
      format,
      path,
      professor,
      status,
      subjectname,
      subject_code,
      thumbnail,
      TopicName;

  WhatsNewModelVLA.fromJson(Map<String, dynamic> json)
      : classname = json['classname'],
        Class_id = (json['Class_id'] == null) ? "" : json['Class_id'],
        concept = json['concept'],
        duration = json['duration'],
        filename = json['filename'],
        format = json['format'],
        path = json['path'],
        professor = json['professor'],
        status = json['status'],
        subjectname = json['subjectname'],
        subject_code = json['subject_code'],
        thumbnail = json['thumbnail'],
        TopicName = json['TopicName'];

  Map<String, dynamic> toJson() => {
        'classname': classname,
        'Class_id': Class_id,
        'concept': concept,
        'duration': duration,
        'filename': filename,
        'format': format,
        'path': path,
        'professor': professor,
        'status': status,
        'subjectname': subjectname,
        'subject_code': subject_code,
        'thumbnail': thumbnail,
        'TopicName': TopicName,
      };
}
