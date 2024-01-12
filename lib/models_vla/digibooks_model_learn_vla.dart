import 'package:flutter/material.dart';
import 'package:vel_app_online/models_vla/digibooks_notes_model_learn_vla.dart';

class DigibooksModelLearnVLA {
  String TopicName, _IdTopicMaster;

  List<DigibooksNotesModelLearnVLA> notes = [];

  DigibooksModelLearnVLA(this.TopicName, this._IdTopicMaster, this.notes);

  factory DigibooksModelLearnVLA.fromJson(Map<String, dynamic> json) {
    List<DigibooksNotesModelLearnVLA> listDigibooksNotesModelLearnVLA = [];

    List<dynamic> notesListTemp = json['notes'];
    for (int i = 0; i < notesListTemp.length; i++) {
      listDigibooksNotesModelLearnVLA
          .add(DigibooksNotesModelLearnVLA.fromJson(notesListTemp[i]));
    }

    return DigibooksModelLearnVLA(json['TopicName'], json['_IdTopicMaster'],
        listDigibooksNotesModelLearnVLA);
  }
}
