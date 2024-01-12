class TestModelVLA {
  String class_id, id, sessions, thumbnails;

  TestModelVLA(this.class_id, this.id, this.sessions, this.thumbnails);

  factory TestModelVLA.fromJson(Map<String, dynamic> json) {
    return TestModelVLA(
        json['class_id'], json['id'], json['sessions'], json['thumbnails']);
  }

  Map<String, dynamic> toJson() => {
        'class_id': class_id,
        'id': id,
        'sessions': sessions,
        'thumbnails': thumbnails,
      };
}
