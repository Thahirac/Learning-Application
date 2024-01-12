import 'package:vel_app_online/models_vla/subject_wise_analysis_notes_model_vla.dart';

class SubjectWiseAnalysisModelVLA {
  String Class_id, image, SubjectName, subject_code, IdSubjectMaster;
  List<SubSubjectWiseAnalysisNotesModelVLA> notes = [];

  SubjectWiseAnalysisModelVLA(this.Class_id, this.image, this.notes,
      this.SubjectName, this.subject_code, this.IdSubjectMaster);

  factory SubjectWiseAnalysisModelVLA.fromJson(Map<String, dynamic> json) {
    List<SubSubjectWiseAnalysisNotesModelVLA>
        listSubjectWiseAnalysisNotesModelVLA = [];

    List<dynamic> notesListTemp = json['notes'];
    for (int i = 0; i < notesListTemp.length; i++) {
      listSubjectWiseAnalysisNotesModelVLA.add(SubSubjectWiseAnalysisNotesModelVLA.fromJson(notesListTemp[i]));
    }

    return SubjectWiseAnalysisModelVLA(
      json['Class_id'],
      json['image'],
      listSubjectWiseAnalysisNotesModelVLA,
      json['SubjectName'],
      json['subject_code'],
      json['_IdSubjectMaster'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Class_id': Class_id,
        'image': image,
        'notes': notes.toString(),
        'SubjectName': SubjectName,
        'subject_code': subject_code,
        '_IdSubjectMaster': IdSubjectMaster,
      };
}
