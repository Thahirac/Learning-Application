class ProfileModelVLA {
  String bloodgroup,
      district,
      DOB,
      email,
      mobile,
      name,
      school,
      school_id,
      status;

  ProfileModelVLA(this.bloodgroup, this.district, this.DOB, this.email,
      this.mobile, this.name, this.school, this.school_id, this.status);

  ProfileModelVLA.fromJson(Map<String, dynamic> json)
      : bloodgroup = (json['bloodgroup'] == null) ? "" : json['bloodgroup'],
        district = (json['district'] == null) ? "" : json['district'],
        DOB = (json['DOB'] == null) ? "" : json['DOB'],
        email = (json['email'] == null) ? "" : json['email'],
        mobile = (json['mobile'] == null) ? "" : json['mobile'],
        name = (json['name'] == null) ? "" : json['name'],
        school = (json['school'] == null) ? "" : json['school'],
        school_id = (json['school_id'] == null) ? "" : json['school_id'],
        status = (json['status'] == null) ? "" : json['status'];

  Map<String, dynamic> toJson() => {
        'bloodgroup': bloodgroup,
        'district': district,
        'DOB': DOB,
        'email': email,
        'mobile': mobile,
        'name': name,
        'school': school,
        'school_id': school_id,
        'status': status,
      };
}
