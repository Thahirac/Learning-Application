class SubSubjectWiseAnalysisNotesModelVLA {
  int counts;

  String progress;

  SubSubjectWiseAnalysisNotesModelVLA(this.counts, this.progress);

  SubSubjectWiseAnalysisNotesModelVLA.fromJson(Map<String, dynamic> json)
      : counts = (json['counts'] == null) ? "" : json['counts'],
        progress = (json['progress'] == null) ? "" : json['progress'];

  Map<String, dynamic> toJson() => {
        'counts': counts,
        'progress': progress,
      };
}
