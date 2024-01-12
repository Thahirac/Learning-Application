class VirtualClassModelVLA {
  String classname,
      class_id,
      date,
      description,
      link,
      status,
      status_description,
      thumbnail,
      tittle;

  VirtualClassModelVLA(
      this.classname,
      this.class_id,
      this.date,
      this.description,
      this.link,
      this.status,
      this.status_description,
      this.thumbnail,
      this.tittle);

  VirtualClassModelVLA.fromJson(Map<String, dynamic> json)
      : classname = json['classname'],
        class_id = json['class_id'],
        date = json['date'],
        description = json['description'],
        link = json['link'],
        status = json['status'],
        status_description = json['status_description'],
        thumbnail = json['thumbnail'],
        tittle = json['tittle'];

  Map<String, dynamic> toJson() => {
        'classname': classname,
        'class_id': class_id,
        'date': date,
        'description': description,
        'link': link,
        'status': status,
        'status_description': status_description,
        'thumbnail': thumbnail,
        'tittle': tittle,
      };
}
