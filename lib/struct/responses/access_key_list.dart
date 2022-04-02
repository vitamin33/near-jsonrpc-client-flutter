// To parse this JSON data, do
//
//     final accessKeyList = accessKeyListFromJson(jsonString);

import 'dart:convert';

import 'access_key_view.dart';

class AccessKeyList {
  AccessKeyList({
    required this.blockHeight,
    required this.blockHash,
    required this.keys,
  });

  final int blockHeight;
  final String blockHash;
  final List<Key> keys;

  factory AccessKeyList.fromRawJson(String str) => AccessKeyList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccessKeyList.fromJson(Map<String, dynamic> json) => AccessKeyList(
    blockHeight: json["blockHeight"],
    blockHash: json["blockHash"],
    keys: List<Key>.from(json["keys"].map((x) => Key.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "blockHeight": blockHeight,
    "blockHash": blockHash,
    "keys": List<dynamic>.from(keys.map((x) => x.toJson())),
  };
}

class Key {
  Key({
    required this.publicKey,
    required this.accessKey,
  });

  final String publicKey;
  final AccessKeyView accessKey;

  factory Key.fromRawJson(String str) => Key.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Key.fromJson(Map<String, dynamic> json) => Key(
    publicKey: json["publicKey"],
    accessKey: AccessKeyView.fromJson(json["accessKey"]),
  );

  Map<String, dynamic> toJson() => {
    "publicKey": publicKey,
    "accessKey": accessKey.toJson(),
  };
}
