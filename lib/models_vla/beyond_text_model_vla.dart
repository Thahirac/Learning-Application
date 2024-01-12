class BeyondTextModelVLA {
  String class_id, ContentPath, filename, name, path, status, thumbnail, type;

  BeyondTextModelVLA.fromJson(Map<String, dynamic> json)
      : class_id = (json['class_id'] == null) ? "" : json['class_id'],
        ContentPath = (json['ContentPath'] == null) ? "" : json['ContentPath'],
        filename = (json['filename'] == null) ? "" : json['filename'],
        name = (json['name'] == null) ? "" : json['name'],
        path = (json['path'] == null) ? "" : json['path'],
        status = (json['status'] == null) ? "" : json['status'],
        thumbnail = (json['thumbnail'] == null) ? "" : json['thumbnail'],
        type = (json['type'] == null) ? "" : json['type'];

  Map<String, dynamic> toJson() => {
        'class_id': class_id,
        'ContentPath': ContentPath,
        'filename': filename,
        'name': name,
        'path': path,
        'status': status,
        'thumbnail': thumbnail,
        'type': type,
      };
}
