class SwitchGradeModelVLA {
  String board_id, classname, Class_id, Medium, real_class, Status, thumb;

  SwitchGradeModelVLA(this.board_id, this.classname, this.Class_id, this.Medium,
      this.real_class, this.Status, this.thumb);

  factory SwitchGradeModelVLA.fromJson(Map<String, dynamic> json) {
    return SwitchGradeModelVLA(
        json['board_id'],
        json['classname'],
        json['Class_id'],
        json['Medium'],
        json['real_class'],
        json['Status'],
        json['thumb']);
  }

  Map<String, dynamic> toJson() => {
        'board_id': board_id,
        'classname': classname,
        'Class_id': Class_id,
        'Medium': Medium,
        'real_class': real_class,
        'Status': Status,
        'thumb': thumb
      };
}
