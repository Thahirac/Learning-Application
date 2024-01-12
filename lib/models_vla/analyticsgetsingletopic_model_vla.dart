
class AnalyticsgetsingletopicModal {
  String? module;
  String? duration;
  List<Type>? type;

  AnalyticsgetsingletopicModal({
    this.module,
    this.duration,
    this.type,
  });

  factory AnalyticsgetsingletopicModal.fromJson(Map<String, dynamic> json) => AnalyticsgetsingletopicModal(
    module: json["module"],
    duration: json["duration"],
    type: json["type"] == null ? [] : List<Type>.from(json["type"]!.map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "module": module,
    "duration": duration,
    "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x.toJson())),
  };
}

class Type {
  String? type;
  String? duration;
  String? typeName;

  Type({
    this.type,
    this.duration,
    this.typeName,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    type: json["type"],
    duration: json["duration"],
    typeName: json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "duration": duration,
    "type_name": typeName,
  };
}
