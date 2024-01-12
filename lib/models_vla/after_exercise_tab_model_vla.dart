class AfterExerciseTabModelVLA {
  String active,
      cid,
      classid,
      contentpath,
      ctid,
      displayname,
      filename,
      format,
      sid,
      status,
      thumbnail,
      tid;

  AfterExerciseTabModelVLA.fromJson(Map<String, dynamic> json)
      : active = (json['active'] == null) ? "" : json['active'],
        cid = (json['cid'] == null) ? "" : json['cid'],
        classid = (json['classid'] == null) ? "" : json['classid'],
        contentpath = (json['contentpath'] == null) ? "" : json['contentpath'],
        ctid = (json['ctid'] == null) ? "" : json['ctid'],
        displayname = (json['displayname'] == null) ? "" : json['displayname'],
        filename = (json['filename'] == null) ? "" : json['filename'],
        format = (json['format'] == null) ? "" : json['format'],
        sid = (json['sid'] == null) ? "" : json['sid'],
        status = (json['status'] == null) ? "" : json['status'],
        thumbnail = (json['thumbnail'] == null) ? "" : json['thumbnail'],
        tid = (json['tid'] == null) ? "" : json['tid'];

/*active,cid,classid,contentpath,ctid,displayname,filename,format,
  sid,status,thumbnail,tid
  */
  Map<String, dynamic> toJson() => {
        'active': active,
        'cid': cid,
        'classid': classid,
        'contentpath': contentpath,
        'ctid': ctid,
        'displayname': displayname,
        'filename': filename,
        'format': format,
        'sid': sid,
        'status': status,
        'thumbnail': thumbnail,
        'tid': tid,
      };
}
