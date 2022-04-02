// To parse this JSON data, do
//
//     final accessKeyView = accessKeyViewFromJson(jsonString);

import 'dart:convert';

class AccessKeyView {
  AccessKeyView({
    required this.blockHeight,
    required this.blockHash,
    required this.nonce,
    required this.permission,
  });

  final int blockHeight;
  final String blockHash;
  final int nonce;
  final Permission permission;

  factory AccessKeyView.fromRawJson(String str) => AccessKeyView.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccessKeyView.fromJson(Map<String, dynamic> json) => AccessKeyView(
    blockHeight: json["blockHeight"],
    blockHash: json["blockHash"],
    nonce: json["nonce"],
    permission: Permission.fromJson(json["permission"]),
  );

  Map<String, dynamic> toJson() => {
    "blockHeight": blockHeight,
    "blockHash": blockHash,
    "nonce": nonce,
    "permission": permission.toJson(),
  };
}

class Permission {
  Permission({
    required this.functionCall,
  });

  final FunctionCall functionCall;

  factory Permission.fromRawJson(String str) => Permission.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    functionCall: FunctionCall.fromJson(json["functionCall"]),
  );

  Map<String, dynamic> toJson() => {
    "functionCall": functionCall.toJson(),
  };
}

class FunctionCall {
  FunctionCall({
    required this.allowance,
    required this.receiverId,
    required this.methodNames,
  });

  final String allowance;
  final String receiverId;
  final List<String> methodNames;

  factory FunctionCall.fromRawJson(String str) => FunctionCall.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FunctionCall.fromJson(Map<String, dynamic> json) => FunctionCall(
    allowance: json["allowance"],
    receiverId: json["receiverId"],
    methodNames: List<String>.from(json["methodNames"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "allowance": allowance,
    "receiverId": receiverId,
    "methodNames": List<dynamic>.from(methodNames.map((x) => x)),
  };
}
