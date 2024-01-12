class PUCEachSubjectModelVLA {
  String active, classid, sid, status, subjectname, sub_code, thumbnail;

  PUCEachSubjectModelVLA(this.active, this.classid, this.sid, this.status,
      this.subjectname, this.sub_code, this.thumbnail);

  PUCEachSubjectModelVLA.fromJson(Map<String, dynamic> json)
      : active = (json['active'] == null) ? "" : json['active'],
        classid = (json['classid'] == null) ? "" : json['classid'],
        sid = (json['sid'] == null) ? "" : json['sid'],
        status = (json['status'] == null) ? "" : json['status'],
        subjectname = (json['subjectname'] == null) ? "" : json['subjectname'],
        sub_code = (json['sub_code'] == null) ? "" : json['sub_code'],
        thumbnail = (json['thumbnail'] == null) ? "" : json['thumbnail'];

  Map<String, dynamic> toJson() => {
        'active': active,
        'classid': classid,
        'sid': sid,
        'status': status,
        'subjectname': subjectname,
        'sub_code': sub_code,
        'thumbnail': thumbnail,
      };
}
