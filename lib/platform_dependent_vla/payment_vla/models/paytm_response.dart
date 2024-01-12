// To parse this JSON data, do
//
//     final paytmResponse = paytmResponseFromJson(jsonString);

import 'dart:convert';

PaytmResponse paytmResponseFromJson(String str) => PaytmResponse.fromJson(json.decode(str));

String paytmResponseToJson(PaytmResponse data) => json.encode(data.toJson());

class PaytmResponse {
  PaytmResponse({
    this.currency,
    this.gatewayname,
    this.respmsg,
    this.bankname,
    this.paymentmode,
    this.mid,
    this.respcode,
    this.txnamount,
    this.txnid,
    this.orderid,
    this.status,
    this.banktxnid,
    this.txndate,
    this.checksumhash,
  });

  String? currency;
  String? gatewayname;
  String? respmsg;
  String? bankname;
  String? paymentmode;
  String? mid;
  String? respcode;
  String? txnamount;
  String? txnid;
  String? orderid;
  String? status;
  String? banktxnid;
  String? txndate;
  String? checksumhash;

  factory PaytmResponse.fromJson(Map<dynamic, dynamic> json) => PaytmResponse(
    currency: json["CURRENCY"],
    gatewayname: json["GATEWAYNAME"],
    respmsg: json["RESPMSG"],
    bankname: json["BANKNAME"],
    paymentmode: json["PAYMENTMODE"],
    mid: json["MID"],
    respcode: json["RESPCODE"],
    txnamount: json["TXNAMOUNT"],
    txnid: json["TXNID"],
    orderid: json["ORDERID"],
    status: json["STATUS"],
    banktxnid: json["BANKTXNID"],
    txndate: json["TXNDATE"],
    checksumhash: json["CHECKSUMHASH"],
  );

  Map<String, dynamic> toJson() => {
    "CURRENCY": currency,
    "GATEWAYNAME": gatewayname,
    "RESPMSG": respmsg,
    "BANKNAME": bankname,
    "PAYMENTMODE": paymentmode,
    "MID": mid,
    "RESPCODE": respcode,
    "TXNAMOUNT": txnamount,
    "TXNID": txnid,
    "ORDERID": orderid,
    "STATUS": status,
    "BANKTXNID": banktxnid,
    "TXNDATE": txndate,
    "CHECKSUMHASH": checksumhash,
  };
}
