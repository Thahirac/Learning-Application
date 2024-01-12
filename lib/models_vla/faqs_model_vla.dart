class FAQsModelVLA {
  String Answer, Question, Status;

  FAQsModelVLA(this.Answer, this.Question, this.Status);

  factory FAQsModelVLA.fromJson(Map<String, dynamic> json) {
    return FAQsModelVLA(json['Answer'], json['Question'], json['Status']);
  }

  Map<String, dynamic> toJson() =>
      {'Answer': Answer, 'Question': Question, 'Status': Status};
}
