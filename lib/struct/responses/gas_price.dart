// To parse this JSON data, do
//
//     final gasPrice = gasPriceFromJson(jsonString);

import 'dart:convert';

class GasPrice {
  GasPrice({
    required this.gasPrice,
  });

  final String gasPrice;

  factory GasPrice.fromRawJson(String str) => GasPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GasPrice.fromJson(Map<String, dynamic> json) => GasPrice(
    gasPrice: json["gasPrice"],
  );

  Map<String, dynamic> toJson() => {
    "gasPrice": gasPrice,
  };
}
