// To parse this JSON data, do
//
//     final epochValidatorInfo = epochValidatorInfoFromJson(jsonString);

import 'dart:convert';

class EpochValidatorInfo {
  EpochValidatorInfo({
    required this.nextValidators,
    required this.currentValidators,
    required this.nextFisherman,
    required this.currentFisherman,
    required this.currentProposals,
    required this.epochStartHeight,
    required this.prevEpochKickout,
  });

  final List<CurrentFisherman> nextValidators;
  final List<CurrentValidator> currentValidators;
  final List<CurrentFisherman> nextFisherman;
  final List<CurrentFisherman> currentFisherman;
  final List<CurrentFisherman> currentProposals;
  final String epochStartHeight;
  final List<CurrentFisherman> prevEpochKickout;

  factory EpochValidatorInfo.fromRawJson(String str) => EpochValidatorInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EpochValidatorInfo.fromJson(Map<String, dynamic> json) => EpochValidatorInfo(
    nextValidators: List<CurrentFisherman>.from(json["nextValidators"].map((x) => CurrentFisherman.fromJson(x))),
    currentValidators: List<CurrentValidator>.from(json["currentValidators"].map((x) => CurrentValidator.fromJson(x))),
    nextFisherman: List<CurrentFisherman>.from(json["nextFisherman"].map((x) => CurrentFisherman.fromJson(x))),
    currentFisherman: List<CurrentFisherman>.from(json["currentFisherman"].map((x) => CurrentFisherman.fromJson(x))),
    currentProposals: List<CurrentFisherman>.from(json["currentProposals"].map((x) => CurrentFisherman.fromJson(x))),
    epochStartHeight: json["epochStartHeight"],
    prevEpochKickout: List<CurrentFisherman>.from(json["prevEpochKickout"].map((x) => CurrentFisherman.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nextValidators": List<dynamic>.from(nextValidators.map((x) => x.toJson())),
    "currentValidators": List<dynamic>.from(currentValidators.map((x) => x.toJson())),
    "nextFisherman": List<dynamic>.from(nextFisherman.map((x) => x.toJson())),
    "currentFisherman": List<dynamic>.from(currentFisherman.map((x) => x.toJson())),
    "currentProposals": List<dynamic>.from(currentProposals.map((x) => x.toJson())),
    "epochStartHeight": epochStartHeight,
    "prevEpochKickout": List<dynamic>.from(prevEpochKickout.map((x) => x.toJson())),
  };
}

class CurrentFisherman {
  CurrentFisherman({
    required this.accountId,
    required this.publicKey,
    required this.stake,
    required this.shards,
  });

  final String accountId;
  final String publicKey;
  final String stake;
  final List<String?>? shards;

  factory CurrentFisherman.fromRawJson(String str) => CurrentFisherman.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrentFisherman.fromJson(Map<String, dynamic> json) => CurrentFisherman(
    accountId: json["accountId"],
    publicKey: json["publicKey"],
    stake: json["stake"],
    shards: json["shards"] == null ? null : List<String>.from(json["shards"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "accountId": accountId,
    "publicKey": publicKey,
    "stake": stake,
    "shards": shards == null ? null : List<String>.from(shards!.map((x) => x)),
  };
}

class CurrentValidator {
  CurrentValidator({
    required this.accountId,
    required this.publicKey,
    required this.stake,
    required this.shards,
    required this.isSlashed,
    required this.numProducedBlocks,
    required this.numExpectedBlocks,
  });

  final String accountId;
  final String publicKey;
  final String stake;
  final List<int> shards;
  final bool isSlashed;
  final int numProducedBlocks;
  final int numExpectedBlocks;

  factory CurrentValidator.fromRawJson(String str) => CurrentValidator.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrentValidator.fromJson(Map<String, dynamic> json) => CurrentValidator(
    accountId: json["accountId"],
    publicKey: json["publicKey"],
    stake: json["stake"],
    shards: List<int>.from(json["shards"].map((x) => x)),
    isSlashed: json["isSlashed"],
    numProducedBlocks: json["numProducedBlocks"],
    numExpectedBlocks: json["numExpectedBlocks"],
  );

  Map<String, dynamic> toJson() => {
    "accountId": accountId,
    "publicKey": publicKey,
    "stake": stake,
    "shards": List<dynamic>.from(shards.map((x) => x)),
    "isSlashed": isSlashed,
    "numProducedBlocks": numProducedBlocks,
    "numExpectedBlocks": numExpectedBlocks,
  };
}
