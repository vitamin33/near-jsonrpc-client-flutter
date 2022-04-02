// To parse this JSON data, do
//
//     final accountView = accountViewFromJson(jsonString);

import 'dart:convert';

class AccountView {
  AccountView({
    required this.blockHeight,
    required this.blockHash,
    required this.amount,
    required this.locked,
    required this.codeHash,
    required this.storageUsage,
    required this.storagePaidAt,
  });

  final int blockHeight;
  final String blockHash;
  final String amount;
  final String locked;
  final String codeHash;
  final String storageUsage;
  final int storagePaidAt;

  factory AccountView.fromRawJson(String str) => AccountView.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountView.fromJson(Map<String, dynamic> json) => AccountView(
    blockHeight: json["blockHeight"],
    blockHash: json["blockHash"],
    amount: json["amount"],
    locked: json["locked"],
    codeHash: json["codeHash"],
    storageUsage: json["storageUsage"],
    storagePaidAt: json["storagePaidAt"],
  );

  Map<String, dynamic> toJson() => {
    "blockHeight": blockHeight,
    "blockHash": blockHash,
    "amount": amount,
    "locked": locked,
    "codeHash": codeHash,
    "storageUsage": storageUsage,
    "storagePaidAt": storagePaidAt,
  };
}
