class MCQModelVLA {
  String Explanation,
      Option1,
      Option2,
      Option3,
      Option4,
      Question,
      RightAnswer,
      Topic_id,
      userAnswer;

  MCQModelVLA(
      this.Explanation,
      this.Option1,
      this.Option2,
      this.Option3,
      this.Option4,
      this.Question,
      this.RightAnswer,
      this.Topic_id,
      this.userAnswer);

  factory MCQModelVLA.fromJson(Map<String, dynamic> json) {
    return MCQModelVLA(
        "",
        json['Option1'],
        json['Option2'],
        json['Option3'],
        json['Option4'],
        json['Question'],
        json['RightAnswer'],
        json['Topic_id'],
        "0");
  }

  Map<String, dynamic> toJson() => {
        'Explanation': Explanation,
        'Option1': Option1,
        'Option2': Option2,
        'Option3': Option3,
        'Option4': Option4,
        'Question': Question,
        'RightAnswer': RightAnswer,
        'Topic_id': Topic_id,
        '0': userAnswer
      };
}
