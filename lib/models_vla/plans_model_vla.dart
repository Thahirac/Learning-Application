class PlansModelVLA {
  String actual_price,
      actual_subject_price,
      class_id,
      class_price,
      class_validity,
      description,
      feature,
      full_subject,
      keyId,
      keySecret,
      plan_id,
      promocode_status,
      Status,
      subject_id,
      subject_name,
      subject_price,
      subject_validity;


  PlansModelVLA(
      this.actual_price,
      this.actual_subject_price,
      this.class_id,
      this.class_price,
      this.class_validity,
      this.description,
      this.feature,
      this.full_subject,
      this.keyId,
      this.keySecret,
      this.plan_id,
      this.promocode_status,
      this.Status,
      this.subject_id,
      this.subject_name,
      this.subject_price,
      this.subject_validity);

  PlansModelVLA.fromJson(Map<String, dynamic> json)
      : actual_price =
            (json['actual_price'] == null) ? "" : json['actual_price'],
        actual_subject_price = (json['actual_subject_price'] == null)
            ? ""
            : json['actual_subject_price'],
        class_id = (json['class_id'] == null) ? "" : json['class_id'],
        class_price = (json['class_price'] == null) ? "" : json['class_price'],
        class_validity =
            (json['class_validity'] == null) ? "" : json['class_validity'],
        description = (json['description'] == null) ? "" : json['description'],
        feature = (json['feature'] == null) ? "" : json['feature'],
        full_subject =
            (json['full_subject'] == null) ? "" : json['full_subject'],
        keyId = (json['keyId'] == null) ? "" : json['keyId'],
        keySecret = (json['keySecret'] == null) ? "" : json['keySecret'],
        plan_id = (json['plan_id'] == null) ? "" : json['plan_id'],
        promocode_status =
            (json['promocode_status'] == null) ? "" : json['promocode_status'],
        Status = (json['Status'] == null) ? "" : json['Status'],
        subject_id = (json['subject_id'] == null) ? "" : json['subject_id'],
        subject_name =
            (json['subject_name'] == null) ? "" : json['subject_name'],
        subject_price =
            (json['subject_price'] == null) ? "" : json['subject_price'],
        subject_validity =
            (json['subject_validity'] == null) ? "" : json['subject_validity'];

  Map<String, dynamic> toJson() => {
        'actual_price': actual_price,
        'actual_subject_price': actual_subject_price,
        'class_id': class_id,
        'class_price': class_price,
        'class_validity': class_validity,
        'description': description,
        'feature': feature,
        'full_subject': full_subject,
        'keyId': keyId,
        'keySecret': keySecret,
        'plan_id': plan_id,
        'promocode_status': promocode_status,
        'Status': Status,
        'subject_id': subject_id,
        'subject_name': subject_name,
        'subject_price': subject_price,
        'subject_validity': subject_validity,
      };
}
