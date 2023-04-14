// ignore_for_file: file_names
import 'dart:convert';

class BaseMusicInfo {
  BaseMusicInfo({
    required this.name,
    required this.url,
    required this.dur,
  });

  String name;
  String url;
  String dur;

  factory BaseMusicInfo.fromRawJson(String str) =>
      BaseMusicInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseMusicInfo.fromJson(Map<String, dynamic> json) => BaseMusicInfo(
        name: json["name"],
        url: json["url"],
        dur: json["dur"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "dur": dur,
      };
}