import 'dart:convert';

DataSound dataSoundJson(String str) => DataSound.fromJson(json.decode(str));

String dataSoundToJson(DataSound data) => json.encode(data.toJson());

class DataSound {
  int id;
  int userId;
  String label;
  String soundUri;
  String algorithm;
  DateTime dateCreated;

  DataSound({
    required this.id,
    required this.userId,
    required this.label,
    required this.soundUri,
    required this.algorithm,
    required this.dateCreated,
  });

  factory DataSound.fromJson(Map<String, dynamic> json) => DataSound(
        id: json["id"],
        userId: json["user_id"],
        label: json["label"],
        soundUri: json["sound_uri"],
        algorithm: json["algorithm"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "label": label,
        "sound_uri": soundUri,
        "algorithm": algorithm,
        "date_created": dateCreated.toIso8601String(),
      };
}
