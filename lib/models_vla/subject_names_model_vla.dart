import 'package:flutter/material.dart';

class SubjectNamesModelVLA {
  String Class_id,
      IdParent,
      image,
      status,
      SubjectName,
      subject_code,
      IdSubjectMaster;

  SubjectNamesModelVLA(this.Class_id, this.IdParent, this.image, this.status,
      this.SubjectName, this.subject_code, this.IdSubjectMaster);

  SubjectNamesModelVLA.fromJson(Map<String, dynamic> json)
      : Class_id = json['Class_id'],
        IdParent = json['IdParent'],
        image = json['image'],
        status = json['status'],
        SubjectName = json['SubjectName'],
        subject_code = json['subject_code'],
        IdSubjectMaster = json['_IdSubjectMaster'];

  Map<String, dynamic> toJson() => {
        'Class_id': Class_id,
        'IdParent': IdParent,
        'image': image,
        'status': status,
        'SubjectName': SubjectName,
        'subject_code': subject_code,
        '_IdSubjectMaster': IdSubjectMaster,
      };
}
