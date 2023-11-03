// To parse this JSON data, do
//
//     final sampleModel = sampleModelFromJson(jsonString);

import 'dart:convert';

SampleModel sampleModelFromJson(String str) => SampleModel.fromJson(json.decode(str));

String sampleModelToJson(SampleModel data) => json.encode(data.toJson());

class SampleModel {
    List<Payload>? payload;

    SampleModel({
        this.payload,
    });

    factory SampleModel.fromJson(Map<String, dynamic> json) => SampleModel(
        payload: json["payload"] == null ? [] : List<Payload>.from(json["payload"]!.map((x) => Payload.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "payload": payload == null ? [] : List<dynamic>.from(payload!.map((x) => x.toJson())),
    };
}

class Payload {
    String? payloadId;
    List<Datum>? data;
    int? amount;

    Payload({
        this.payloadId,
        this.data,
        this.amount,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        payloadId: json["payloadId"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "payloadId": payloadId,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "amount": amount,
    };
}

class Datum {
    String? id;
    String? name;
    String? surname;

    Datum({
        this.id,
        this.name,
        this.surname,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
    };
}
