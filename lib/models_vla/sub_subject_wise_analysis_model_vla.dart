import 'package:vel_app_online/models_vla/subject_wise_analysis_notes_model_vla.dart';
import 'package:vel_app_online/models_vla/subject_wise_analysis_totaltime_model_vla.dart';

class SubSubjectWiseAnalysisModelVLA {
  String topicName;
  String  topicId;
  List<SubSubjectWiseAnalysisTotaltimeModelVLA> totaltime = [];

  SubSubjectWiseAnalysisModelVLA(this.topicName, this.topicId, this.totaltime,);

  factory SubSubjectWiseAnalysisModelVLA.fromJson(Map<String, dynamic> json) {
    List<SubSubjectWiseAnalysisTotaltimeModelVLA> listSubjectWiseAnalysisTotaltimeModelVLA = [];

    List<dynamic> totaltimeListTemp = json['total_time'];
    for (int i = 0; i < totaltimeListTemp.length; i++) {
      listSubjectWiseAnalysisTotaltimeModelVLA
          .add(SubSubjectWiseAnalysisTotaltimeModelVLA.fromJson(totaltimeListTemp[i]));
    }

    return SubSubjectWiseAnalysisModelVLA(
      json["topic_name"],
      json["topic_id"],
      listSubjectWiseAnalysisTotaltimeModelVLA,
    );
  }

  Map<String, dynamic> toJson() => {
    "topic_name": topicName,
    "topic_id": topicId,
    'total_time': totaltime.toString(),
  };
}
