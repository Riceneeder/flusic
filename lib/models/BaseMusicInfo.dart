// ignore_for_file: file_names
import 'dart:convert';

class BaseMusicInfo {
  BaseMusicInfo({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory BaseMusicInfo.fromRawJson(String str) =>
      BaseMusicInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BaseMusicInfo.fromJson(Map<String, dynamic> json) => BaseMusicInfo(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
