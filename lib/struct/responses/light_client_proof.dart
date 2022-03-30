// To parse this JSON data, do
//
//     final lightClientProof = lightClientProofFromJson(jsonString);

import 'dart:convert';

class LightClientProof {
  LightClientProof({
    required this.outcomeProof,
    required this.outcomeRootProof,
    required this.blockProof,
    required this.blockHeaderLite,
  });

  final OutcomeProof outcomeProof;
  final List<Proof> outcomeRootProof;
  final List<Proof> blockProof;
  final BlockHeaderLite blockHeaderLite;

  factory LightClientProof.fromRawJson(String str) => LightClientProof.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LightClientProof.fromJson(Map<String, dynamic> json) => LightClientProof(
    outcomeProof: OutcomeProof.fromJson(json["outcomeProof"]),
    outcomeRootProof: List<Proof>.from(json["outcomeRootProof"].map((x) => Proof.fromJson(x))),
    blockProof: List<Proof>.from(json["blockProof"].map((x) => Proof.fromJson(x))),
    blockHeaderLite: BlockHeaderLite.fromJson(json["blockHeaderLite"]),
  );

  Map<String, dynamic> toJson() => {
    "outcomeProof": outcomeProof.toJson(),
    "outcomeRootProof": List<dynamic>.from(outcomeRootProof.map((x) => x.toJson())),
    "blockProof": List<dynamic>.from(blockProof.map((x) => x.toJson())),
    "blockHeaderLite": blockHeaderLite.toJson(),
  };
}

class BlockHeaderLite {
  BlockHeaderLite({
    required this.prevBlockHash,
    required this.innerRestHash,
    required this.innerLite,
  });

  final String prevBlockHash;
  final String innerRestHash;
  final InnerLite innerLite;

  factory BlockHeaderLite.fromRawJson(String str) => BlockHeaderLite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockHeaderLite.fromJson(Map<String, dynamic> json) => BlockHeaderLite(
    prevBlockHash: json["prevBlockHash"],
    innerRestHash: json["innerRestHash"],
    innerLite: InnerLite.fromJson(json["innerLite"]),
  );

  Map<String, dynamic> toJson() => {
    "prevBlockHash": prevBlockHash,
    "innerRestHash": innerRestHash,
    "innerLite": innerLite.toJson(),
  };
}

class InnerLite {
  InnerLite({
    required this.epochId,
    required this.nextEpochId,
    required this.prevStateRoot,
    required this.outcomeRoot,
    required this.nextBpHash,
    required this.blockMerkleRoot,
    required this.height,
    required this.timestamp,
  });

  final String epochId;
  final String nextEpochId;
  final String prevStateRoot;
  final String outcomeRoot;
  final String nextBpHash;
  final String blockMerkleRoot;
  final int height;
  final int timestamp;

  factory InnerLite.fromRawJson(String str) => InnerLite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InnerLite.fromJson(Map<String, dynamic> json) => InnerLite(
    epochId: json["epochId"],
    nextEpochId: json["nextEpochId"],
    prevStateRoot: json["prevStateRoot"],
    outcomeRoot: json["outcomeRoot"],
    nextBpHash: json["nextBpHash"],
    blockMerkleRoot: json["blockMerkleRoot"],
    height: json["height"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "epochId": epochId,
    "nextEpochId": nextEpochId,
    "prevStateRoot": prevStateRoot,
    "outcomeRoot": outcomeRoot,
    "nextBpHash": nextBpHash,
    "blockMerkleRoot": blockMerkleRoot,
    "height": height,
    "timestamp": timestamp,
  };
}

class Proof {
  Proof({
    required this.hash,
    required this.direction,
  });

  final String hash;
  final String direction;

  factory Proof.fromRawJson(String str) => Proof.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Proof.fromJson(Map<String, dynamic> json) => Proof(
    hash: json["hash"],
    direction: json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "hash": hash,
    "direction": direction,
  };
}

class OutcomeProof {
  OutcomeProof({
    required this.blockHash,
    required this.id,
    required this.proof,
    required this.outcome,
  });

  final String blockHash;
  final String id;
  final List<Proof> proof;
  final Outcome outcome;

  factory OutcomeProof.fromRawJson(String str) => OutcomeProof.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OutcomeProof.fromJson(Map<String, dynamic> json) => OutcomeProof(
    blockHash: json["block_hash"],
    id: json["id"],
    proof: List<Proof>.from(json["proof"].map((x) => Proof.fromJson(x))),
    outcome: Outcome.fromJson(json["outcome"]),
  );

  Map<String, dynamic> toJson() => {
    "block_hash": blockHash,
    "id": id,
    "proof": List<dynamic>.from(proof.map((x) => x.toJson())),
    "outcome": outcome.toJson(),
  };
}

class Outcome {
  Outcome({
    required this.logs,
    required this.receiptIds,
    required this.gasBurnt,
    required this.status,
  });

  final List<String> logs;
  final List<String> receiptIds;
  final int gasBurnt;
  final OutcomeStatus status;

  factory Outcome.fromRawJson(String str) => Outcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
    logs: List<String>.from(json["logs"].map((x) => x)),
    receiptIds: List<String>.from(json["receipt_ids"].map((x) => x)),
    gasBurnt: json["gasBurnt"],
    status: OutcomeStatus.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "logs": List<dynamic>.from(logs.map((x) => x)),
    "receipt_ids": List<dynamic>.from(receiptIds.map((x) => x)),
    "gasBurnt": gasBurnt,
    "status": status.toJson(),
  };
}

class OutcomeStatus {
  OutcomeStatus({
    required this.successValue,
    required this.successReceiptId,
    required this.status,
  });

  final String successValue;
  final String successReceiptId;
  final StatusStatus status;

  factory OutcomeStatus.fromRawJson(String str) => OutcomeStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OutcomeStatus.fromJson(Map<String, dynamic> json) => OutcomeStatus(
    successValue: json["successValue"],
    successReceiptId: json["successReceiptId"],
    status: StatusStatus.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "successValue": successValue,
    "successReceiptId": successReceiptId,
    "status": status.toJson(),
  };
}

class StatusStatus {
  StatusStatus({
    required this.errorMessage,
    required this.errorType,
  });

  final String errorMessage;
  final String errorType;

  factory StatusStatus.fromRawJson(String str) => StatusStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatusStatus.fromJson(Map<String, dynamic> json) => StatusStatus(
    errorMessage: json["errorMessage"],
    errorType: json["errorType"],
  );

  Map<String, dynamic> toJson() => {
    "errorMessage": errorMessage,
    "errorType": errorType,
  };
}
