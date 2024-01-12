import 'package:vel_app_online/models_vla/each_puc_digibook_nodes_model_vla.dart';

class EachPUCDigibooksModelVLA {
  String tid, topicname;
  List<EachPUCDigibookNodesModelVLA> notes = [];

  EachPUCDigibooksModelVLA(this.tid, this.topicname, this.notes);

  factory EachPUCDigibooksModelVLA.fromJson(Map<String, dynamic> json) {
    List<EachPUCDigibookNodesModelVLA> listTutorialVideosNotesModelStudyLabVLA =
        [];

    List<dynamic> notesListTemp = json['notes'];
    for (int i = 0; i < notesListTemp.length; i++) {
      listTutorialVideosNotesModelStudyLabVLA
          .add(EachPUCDigibookNodesModelVLA.fromJson(notesListTemp[i]));
    }

    return EachPUCDigibooksModelVLA(json['tid'], json['topicname'],
        listTutorialVideosNotesModelStudyLabVLA);
  }

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'topicname': topicname,
        'notes': notes.toString(),
      };
}
