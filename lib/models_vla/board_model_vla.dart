class BoardModelVLA {
  String BoardName, Board_id, karnataka, pan_india, puc, Status, thumbnail;

  BoardModelVLA.fromJson(Map<String, dynamic> json)
      : BoardName = (json['BoardName'] == null) ? "" : json['BoardName'],
        Board_id = (json['Board_id'] == null) ? "" : json['Board_id'],
        karnataka = (json['karnataka'] == null) ? "" : json['karnataka'],
        pan_india = (json['pan_india'] == null) ? "" : json['pan_india'],
        puc = (json['puc'] == null) ? "" : json['puc'],
        Status = (json['Status'] == null) ? "" : json['Status'],
        thumbnail = (json['thumbnail'] == null) ? "" : json['thumbnail'];

  Map<String, dynamic> toJson() => {
        'BoardName': BoardName,
        'Board_id': Board_id,
        'karnataka': karnataka,
        'pan_india': pan_india,
        'puc': puc,
        'Status': Status,
        'thumbnail': thumbnail,
      };
}
