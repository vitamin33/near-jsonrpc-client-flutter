// To parse this JSON data, do
//
//     final blockChangeResult = blockChangeResultFromJson(jsonString);

import 'dart:convert';

class BlockChangeResult {
  BlockChangeResult({
    required this.header,
  });

  final Header header;

  factory BlockChangeResult.fromRawJson(String str) => BlockChangeResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockChangeResult.fromJson(Map<String, dynamic> json) => BlockChangeResult(
    header: Header.fromJson(json["header"]),
  );

  Map<String, dynamic> toJson() => {
    "header": header.toJson(),
  };
}

class Header {
  Header({
    required this.blockHash,
    required this.changes,
  });

  final String blockHash;
  final List<Change> changes;

  factory Header.fromRawJson(String str) => Header.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    blockHash: json["blockHash"],
    changes: List<Change>.from(json["changes"].map((x) => Change.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "blockHash": blockHash,
    "changes": List<dynamic>.from(changes.map((x) => x.toJson())),
  };
}

class Change {
  Change({
    required this.type,
    required this.accountId,
  });

  final String type;
  final String accountId;

  factory Change.fromRawJson(String str) => Change.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Change.fromJson(Map<String, dynamic> json) => Change(
    type: json["type"],
    accountId: json["accountId"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "accountId": accountId,
  };
}
