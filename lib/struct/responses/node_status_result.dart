// To parse this JSON data, do
//
//     final nodeStatusResult = nodeStatusResultFromJson(jsonString);

import 'dart:convert';

class NodeStatusResult {
  NodeStatusResult({
    required this.chainId,
    required this.rpcAddr,
    required this.syncInfo,
    required this.validators,
    required this.version,
  });

  final String chainId;
  final String rpcAddr;
  final SyncInfo syncInfo;
  final List<String> validators;
  final Version version;

  factory NodeStatusResult.fromRawJson(String str) => NodeStatusResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NodeStatusResult.fromJson(Map<String, dynamic> json) => NodeStatusResult(
    chainId: json["chainId"],
    rpcAddr: json["rpcAddr"],
    syncInfo: SyncInfo.fromJson(json["syncInfo"]),
    validators: List<String>.from(json["validators"].map((x) => x)),
    version: Version.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "chainId": chainId,
    "rpcAddr": rpcAddr,
    "syncInfo": syncInfo.toJson(),
    "validators": List<dynamic>.from(validators.map((x) => x)),
    "version": version.toJson(),
  };
}

class SyncInfo {
  SyncInfo({
    required this.latestBlockHash,
    required this.latestBlockHeight,
    required this.latestBlockTime,
    required this.latestStateRoot,
    required this.syncing,
  });

  final String latestBlockHash;
  final int latestBlockHeight;
  final String latestBlockTime;
  final String latestStateRoot;
  final bool syncing;

  factory SyncInfo.fromRawJson(String str) => SyncInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SyncInfo.fromJson(Map<String, dynamic> json) => SyncInfo(
    latestBlockHash: json["latestBlockHash"],
    latestBlockHeight: json["latestBlockHeight"],
    latestBlockTime: json["latestBlockTime"],
    latestStateRoot: json["latestStateRoot"],
    syncing: json["syncing"],
  );

  Map<String, dynamic> toJson() => {
    "latestBlockHash": latestBlockHash,
    "latestBlockHeight": latestBlockHeight,
    "latestBlockTime": latestBlockTime,
    "latestStateRoot": latestStateRoot,
    "syncing": syncing,
  };
}

class Version {
  Version({
    required this.version,
    required this.build,
  });

  final String version;
  final String build;

  factory Version.fromRawJson(String str) => Version.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Version.fromJson(Map<String, dynamic> json) => Version(
    version: json["version"],
    build: json["build"],
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "build": build,
  };
}
