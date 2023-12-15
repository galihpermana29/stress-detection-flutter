import 'dart:convert';

SoundResponse soundFromJson(String str) =>
    SoundResponse.fromJson(json.decode(str));

String soundToJson(SoundResponse data) => json.encode(data.toJson());

class SoundResponse {
  String data;

  SoundResponse({
    required this.data,
  });

  factory SoundResponse.fromJson(Map<String, dynamic> json) => SoundResponse(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
