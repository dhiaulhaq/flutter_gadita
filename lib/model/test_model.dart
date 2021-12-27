import 'dart:convert';

List<GenderModel> genderModelFromJson(String str) => List<GenderModel>.from(
    json.decode(str).map((x) => GenderModel.fromJson(x)));

String genderModelToJson(List<GenderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenderModel {
  final String name;
  final String gender;
  final double probability;
  final int count;

  GenderModel({
    this.name,
    this.gender,
    this.probability,
    this.count,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
    name: json["name"],
    gender: json["gender"],
    probability: json["probability"].toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "probability": probability,
    "count": count,
  };
}