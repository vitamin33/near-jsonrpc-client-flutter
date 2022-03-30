// To parse this JSON data, do
//
//     final nearProtocolConfig = nearProtocolConfigFromJson(jsonString);

import 'dart:convert';

class NearProtocolConfig {
  NearProtocolConfig({
    required this.runtimeConfig,
  });

  final RuntimeConfig runtimeConfig;

  factory NearProtocolConfig.fromRawJson(String str) => NearProtocolConfig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NearProtocolConfig.fromJson(Map<String, dynamic> json) => NearProtocolConfig(
    runtimeConfig: RuntimeConfig.fromJson(json["runtimeConfig"]),
  );

  Map<String, dynamic> toJson() => {
    "runtimeConfig": runtimeConfig.toJson(),
  };
}

class RuntimeConfig {
  RuntimeConfig({
    required this.storageAmountPerByte,
  });

  final String storageAmountPerByte;

  factory RuntimeConfig.fromRawJson(String str) => RuntimeConfig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RuntimeConfig.fromJson(Map<String, dynamic> json) => RuntimeConfig(
    storageAmountPerByte: json["storageAmountPerByte"],
  );

  Map<String, dynamic> toJson() => {
    "storageAmountPerByte": storageAmountPerByte,
  };
}
