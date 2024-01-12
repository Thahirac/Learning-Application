class SubSubjectWiseAnalysisTotaltimeModelVLA {
  String totalduration;

  SubSubjectWiseAnalysisTotaltimeModelVLA(this.totalduration);

  SubSubjectWiseAnalysisTotaltimeModelVLA.fromJson(Map<String, dynamic> json)
      : totalduration = (json["total_duration"] == null) ? "" : json["total_duration"];

  Map<String, dynamic> toJson() => {
    "total_duration" : totalduration,
  };
}
