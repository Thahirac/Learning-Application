class AfterAssessKitModelVLA {
  String class_id, subjcet, thumbnail, tool, tool_id;

  AfterAssessKitModelVLA(
      this.class_id, this.subjcet, this.thumbnail, this.tool, this.tool_id);

  factory AfterAssessKitModelVLA.fromJson(Map<String, dynamic> json) {
    return AfterAssessKitModelVLA(json['class_id'], json['subjcet'],json['thumbnail'], json['tool'], json['tool_id']);
  }

  Map<String, dynamic> toJson() => {
        'class_id': class_id,
        'subjcet': subjcet,
        'thumbnail': thumbnail,
        'tool': tool,
        'tool_id': tool_id
      };
}
