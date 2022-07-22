import 'dart:convert';

import 'package:flutterbookminimysql/network/api.dart';


List<MsgModel> msgModelFromJson(String str) => List<MsgModel>.from(json.decode(str).map((x) => MsgModel.fromJson(x)));

String msgModelToJson(List<MsgModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MsgModel {
    MsgModel({
        this.username,
        this.proPic,
        this.senderId,
        this.recvId,
    });

    String username;
    String proPic;
    String senderId;
    String recvId;

    factory MsgModel.fromJson(Map<String, dynamic> json) => MsgModel(
        username: json["username"],
        //proPic: "http://192.168.0.102/books/"+json['pro_pic'],
        proPic: BASEURL.Picimage+json['pro_pic'],
        senderId: json["senderID"],
        recvId: json["recvID"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "pro_pic": proPic,
        "senderID": senderId,
        "recvID": recvId,
    };
}
