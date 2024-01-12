class PUCEachExerciseModelVLA {
  String classid, sid, status, tid, topicname;

  PUCEachExerciseModelVLA.fromJson(Map<String, dynamic> json)
      : classid = (json['classid'] == null) ? "" : json['classid'],
        sid = (json['sid'] == null) ? "" : json['sid'],
        status = (json['status'] == null) ? "" : json['status'],
        tid = (json['tid'] == null) ? "" : json['tid'],
        topicname = (json['topicname'] == null) ? "" : json['topicname'];

  Map<String, dynamic> toJson() => {
        'classid': classid,
        'sid': sid,
        'status': status,
        'tid': tid,
        'topicname': topicname,
      };
}
