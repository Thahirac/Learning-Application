class DigibooksNotesModelLearnVLA {
  String ContentName,
      ContentPath,
      Content_ID,
      DisplayName,
      format,
      IdContentTypes,
      IdTopicMaster,
      thumbnail;

  DigibooksNotesModelLearnVLA(
      this.ContentName,
      this.ContentPath,
      this.Content_ID,
      this.DisplayName,
      this.format,
      this.IdContentTypes,
      this.IdTopicMaster,
      this.thumbnail);

  DigibooksNotesModelLearnVLA.fromJson(Map<String, dynamic> json)
      : ContentName = (json['ContentName'] == null) ? "" : json['ContentName'],
        ContentPath = (json['ContentPath'] == null) ? "" : json['ContentPath'],
        Content_ID = (json['Content_ID'] == null) ? "" : json['Content_ID'],
        DisplayName = (json['DisplayName'] == null) ? "" : json['DisplayName'],
        format = (json['format'] == null) ? "" : json['format'],
        IdContentTypes =
            (json['IdContentTypes'] == null) ? "" : json['IdContentTypes'],
        IdTopicMaster =
            (json['IdTopicMaster'] == null) ? "" : json['IdTopicMaster'],
        thumbnail = (json['thumbnail'] == null) ? "" : json['thumbnail'];

  Map<String, dynamic> toJson() => {
        'ContentName': ContentName,
        'ContentPath': ContentPath,
        'Content_ID': Content_ID,
        'DisplayName': DisplayName,
        'format': format,
        'IdContentTypes': IdContentTypes,
        'IdTopicMaster': IdTopicMaster,
        'thumbnail': thumbnail
      };
}
