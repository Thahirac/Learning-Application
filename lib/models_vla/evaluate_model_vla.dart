class EvaluateModelVLA {
  String Class_id, image, SubjectName, subject_code, IdSubjectMaster;

  List<NotesClass> notes = [];

  EvaluateModelVLA(this.Class_id, this.image, this.notes, this.SubjectName,
      this.subject_code, this.IdSubjectMaster);

  factory EvaluateModelVLA.fromJson(Map<String, dynamic> json) {
    List<NotesClass> listNotesClass = [];

    List<dynamic> notesListTemp = json['notes'];
    for (int i = 0; i < notesListTemp.length; i++) {
      listNotesClass.add(NotesClass.fromJson(notesListTemp[i]));
    }

    return EvaluateModelVLA(json['Class_id'], json['image'], listNotesClass,
        json['SubjectName'], json['subject_code'], json['_IdSubjectMaster']);
  }

  Map<String, dynamic> toJson() => {
        'Class_id': Class_id,
        'image': image,
        'notes': notes,
        'SubjectName': SubjectName,
        'subject_code': subject_code,
        '_IdSubjectMaster': IdSubjectMaster
      };
}

class NotesClass {
  int counts;

  NotesClass(this.counts);

  factory NotesClass.fromJson(Map<String, dynamic> json) {
    return NotesClass(json["counts"]);
  }
}
