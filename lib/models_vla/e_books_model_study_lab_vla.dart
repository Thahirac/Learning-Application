class EBooksModelStudyLabVLA {
  String class_id,
      ContentName,
      ContentPath,
      status,
      SubjectName,
      Subject_id,
      Thumbnail,
      url;

  EBooksModelStudyLabVLA.fromJson(Map<String, dynamic> json)
      : class_id = (json['class_id'] == null) ? "" : json['class_id'],
        ContentName = (json['ContentName'] == null) ? "" : json['ContentName'],
        ContentPath = (json['ContentPath'] == null) ? "" : json['ContentPath'],
        status = (json['status'] == null) ? "" : json['status'],
        SubjectName = (json['SubjectName'] == null) ? "" : json['SubjectName'],
        Subject_id = (json['Subject_id'] == null) ? "" : json['Subject_id'],
        Thumbnail = (json['Thumbnail'] == null) ? "" : json['Thumbnail'],
        url = (json['url'] == null) ? "" : json['url'];

  Map<String, dynamic> toJson() => {
        'class_id': class_id,
        'ContentName': ContentName,
        'ContentPath': ContentPath,
        'status': status,
        'SubjectName': SubjectName,
        'Subject_id': Subject_id,
        'Thumbnail': Thumbnail,
        'url': url,
      };
}
//TODO KEEP MORE TO LEFT
