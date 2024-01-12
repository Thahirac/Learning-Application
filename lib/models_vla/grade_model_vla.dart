class GradeModelVLA {
  String board_id,
      category,
      classname,
      Class_id,
      Medium,
      real_class,
      Status,
      thumb;

  GradeModelVLA.fromJson(Map<String, dynamic> json)
      : board_id = (json['board_id'] == null) ? "" : json['board_id'],
        category = (json['category'] == null) ? "" : json['category'],
        classname = (json['classname'] == null) ? "" : json['classname'],
        Class_id = (json['Class_id'] == null) ? "" : json['Class_id'],
        Medium = (json['Medium'] == null) ? "" : json['Medium'],
        real_class = (json['real_class'] == null) ? "" : json['real_class'],
        Status = (json['Status'] == null) ? "" : json['Status'],
        thumb = (json['thumb'] == null) ? "" : json['thumb'];

  Map<String, dynamic> toJson() => {
        'board_id': board_id,
        'category': category,
        'classname': classname,
        'Class_id': Class_id,
        'Medium': Medium,
        'real_class': real_class,
        'Status': Status,
        'thumb': thumb,
      };
}
