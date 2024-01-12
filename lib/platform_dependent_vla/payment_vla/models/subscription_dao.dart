// To parse this JSON data, do
//
//     final subscriptionDao = subscriptionDaoFromJson(jsonString);

import 'dart:convert';

SubscriptionDao subscriptionDaoFromJson(String str) => SubscriptionDao.fromJson(json.decode(str));

String subscriptionDaoToJson(SubscriptionDao data) => json.encode(data.toJson());

class SubscriptionDao {
  SubscriptionDao({
    this.userId,
    this.userName,
    this.classId,
    this.topicId,
    this.startDate,
    this.endDate,
    this.orderId,
    this.txnAmount,
    this.medium,
    this.subscriptionDaoClass,
    this.years,
    this.message,
    this.alarmStartDate,
    this.status,
    this.classSubscribe,
  });

  String? userId;
  String? userName;
  String? classId;
  String? topicId;
  String? startDate;
  String? endDate;
  String? orderId;
  String? txnAmount;
  String? medium;
  String? subscriptionDaoClass;
  String? years;
  String? message;
  String? alarmStartDate;
  String? status;
  String? classSubscribe;

  factory SubscriptionDao.fromJson(Map<String, dynamic> json) => SubscriptionDao(
    userId: json["user_id"],
    userName: json["user_name"],
    classId: json["class_id"],
    topicId: json["topic_id"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    orderId: json["order_id"],
    txnAmount: json["txn_amount"],
    medium: json["medium"],
    subscriptionDaoClass: json["Class"],
    years: json["years"],
    message: json["message"],
    alarmStartDate: json["alarmStartDate"],
    status: json["status"],
    classSubscribe: json["Class_subscribe"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "class_id": classId,
    "topic_id": topicId,
    "start_date": startDate,
    "end_date": endDate,
    "order_id": orderId,
    "txn_amount": txnAmount,
    "medium": medium,
    "Class": subscriptionDaoClass,
    "years": years,
    "message": message,
    "alarmStartDate": alarmStartDate,
    "status": status,
    "Class_subscribe": classSubscribe,
  };
}
