import 'package:flutter/material.dart';
import 'package:vel_app_online/models_vla/tutorial_videos_notes_model_study_lab_vla.dart';

class AllTutorialVideosModelStudyLabVLA {
  String class_id, Subject_id, TopicName, Topic_id;
  List<TutorialVideosNotesModelStudyLabVLA> notes = [];

  AllTutorialVideosModelStudyLabVLA(this.class_id, this.notes, this.Subject_id,
      this.TopicName, this.Topic_id);

  factory AllTutorialVideosModelStudyLabVLA.fromJson(
      Map<String, dynamic> json) {
    List<TutorialVideosNotesModelStudyLabVLA>
        listAllTutorialVideosNotesModelStudyLabVLA = [];

    List<dynamic> notesListTemp = json['notes'];
    for (int i = 0; i < notesListTemp.length; i++) {
      listAllTutorialVideosNotesModelStudyLabVLA.add(
          TutorialVideosNotesModelStudyLabVLA.fromJson(notesListTemp[i]));
    }

    return AllTutorialVideosModelStudyLabVLA(
        json['class_id'],
        listAllTutorialVideosNotesModelStudyLabVLA,
        json['Subject_id'],
        json['TopicName'],
        json['Topic_id']);
  }

  Map<String, dynamic> toJson() => {
        'class_id': class_id,
        'notes': notes.toString(),
        'Subject_id': Subject_id,
        'TopicName': TopicName,
        'Topic_id': Topic_id,
      };
}
