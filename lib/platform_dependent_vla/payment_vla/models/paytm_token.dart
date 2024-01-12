// To parse this JSON data, do
//
//     final paytmToken = paytmTokenFromJson(jsonString);

import 'dart:convert';

PaytmToken paytmTokenFromJson(String str) => PaytmToken.fromJson(json.decode(str));

String paytmTokenToJson(PaytmToken data) => json.encode(data.toJson());

class PaytmToken {
  PaytmToken({
    this.head,
    this.body,
  });

  Head? head;
  Body? body;

  factory PaytmToken.fromJson(Map<String, dynamic> json) => PaytmToken(
    head: Head.fromJson(json["head"]),
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "head": head!.toJson(),
    "body": body!.toJson(),
  };
}

class Body {
  Body({
    this.resultInfo,
    this.txnToken,
    this.isPromoCodeValid,
    this.authenticated,
  });

  ResultInfo? resultInfo;
  String? txnToken;
  bool? isPromoCodeValid;
  bool? authenticated;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    resultInfo: ResultInfo.fromJson(json["resultInfo"]),
    txnToken: json["txnToken"],
    isPromoCodeValid: json["isPromoCodeValid"],
    authenticated: json["authenticated"],
  );

  Map<String, dynamic> toJson() => {
    "resultInfo": resultInfo!.toJson(),
    "txnToken": txnToken,
    "isPromoCodeValid": isPromoCodeValid,
    "authenticated": authenticated,
  };
}

class ResultInfo {
  ResultInfo({
    this.resultStatus,
    this.resultCode,
    this.resultMsg,
  });

  String? resultStatus;
  String? resultCode;
  String? resultMsg;

  factory ResultInfo.fromJson(Map<String, dynamic> json) => ResultInfo(
    resultStatus: json["resultStatus"],
    resultCode: json["resultCode"],
    resultMsg: json["resultMsg"],
  );

  Map<String, dynamic> toJson() => {
    "resultStatus": resultStatus,
    "resultCode": resultCode,
    "resultMsg": resultMsg,
  };
}

class Head {
  Head({
    this.responseTimestamp,
    this.version,
    this.clientId,
    this.signature,
  });

  String? responseTimestamp;
  String? version;
  String? clientId;
  String? signature;

  factory Head.fromJson(Map<String, dynamic> json) => Head(
    responseTimestamp: json["responseTimestamp"],
    version: json["version"],
    clientId: json["clientId"],
    signature: json["signature"],
  );

  Map<String, dynamic> toJson() => {
    "responseTimestamp": responseTimestamp,
    "version": version,
    "clientId": clientId,
    "signature": signature,
  };
}
