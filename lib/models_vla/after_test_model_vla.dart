class AfterTestModelVLA {
  String Classid, id, session_id, status, SubjectName, subject_code;

  AfterTestModelVLA(this.Classid, this.id, this.session_id, this.status,
      this.SubjectName, this.subject_code);

  factory AfterTestModelVLA.fromJson(Map<String, dynamic> json) {
    return AfterTestModelVLA(json['Classid'], json['id'], json['session_id'],
        json['status'], json['SubjectName'], json['subject_code']);
  }

  Map<String, dynamic> toJson() => {
        'Classid': Classid,
        'id': id,
        'session_id': session_id,
        'status': status,
        'SubjectName': SubjectName,
        'subject_code': subject_code
      };
}
