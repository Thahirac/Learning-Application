class OTPVerifiedModelVLA {
  String district,
      email,
      mobile,
      otp,
      reffered,
      status,
      userid,
      username,
      verified;

  List<String> coupenCodes = [];

  OTPVerifiedModelVLA(
      this.district,
      this.email,
      this.mobile,
      this.otp,
      this.reffered,
      this.status,
      this.userid,
      this.username,
      this.verified,
      this.coupenCodes);

  factory OTPVerifiedModelVLA.fromJson(Map<String, dynamic> json) {
    List<String> tempCoupenCodes = [];

    List<dynamic> notesListTemp = json['coupen_code'];
    for (int i = 0; i < notesListTemp.length; i++) {
      tempCoupenCodes.add(notesListTemp[i]);
    }

    return OTPVerifiedModelVLA(
        json['district'],
        json['email'],
        json['mobile'],
        json['otp'],
        json['reffered'],
        json['status'],
        json['userid'],
        json['username'].toString(),
        json['verified'],
        tempCoupenCodes);
  }
}
