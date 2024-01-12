import 'package:flutter/material.dart';
import 'package:vel_app_online/models_vla/tutorial_videos_notes_model_study_lab_vla.dart';

class TutorialVideosModelStudyLabVLA {
  String class_id, SubjectsName, subject_id;
  List<TutorialVideosNotesModelStudyLabVLA> notes = [];

  TutorialVideosModelStudyLabVLA(
      this.class_id, this.notes, this.SubjectsName, this.subject_id);

  factory TutorialVideosModelStudyLabVLA.fromJson(Map<String, dynamic> json) {
    List<TutorialVideosNotesModelStudyLabVLA>
        listTutorialVideosNotesModelStudyLabVLA = [];

    List<dynamic> notesListTemp = json['notes'];
    for (int i = 0; i < notesListTemp.length; i++) {
      listTutorialVideosNotesModelStudyLabVLA
          .add(TutorialVideosNotesModelStudyLabVLA.fromJson(notesListTemp[i]));
    }

    return TutorialVideosModelStudyLabVLA(
        json['class_id'],
        listTutorialVideosNotesModelStudyLabVLA,
        json['SubjectsName'],
        json['subject_id']);
  }

  Map<String, dynamic> toJson() => {
        'class_id': class_id,
        'notes': notes.toString(),
        'SubjectsName': SubjectsName,
        'subject_id': subject_id,
      };
}
