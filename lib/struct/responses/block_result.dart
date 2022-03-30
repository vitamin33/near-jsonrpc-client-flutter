// To parse this JSON data, do
//
//     final blockResult = blockResultFromJson(jsonString);

import 'dart:convert';

class BlockResult {
  BlockResult({
    required this.author,
    required this.header,
    required this.chunks,
  });

  final String author;
  final Header header;
  final List<Chunk> chunks;

  factory BlockResult.fromRawJson(String str) => BlockResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockResult.fromJson(Map<String, dynamic> json) => BlockResult(
    author: json["author"],
    header: Header.fromJson(json["header"]),
    chunks: List<Chunk>.from(json["chunks"].map((x) => Chunk.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "header": header.toJson(),
    "chunks": List<dynamic>.from(chunks.map((x) => x.toJson())),
  };
}

class Chunk {
  Chunk({
    required this.chunkIncluded,
    required this.timestamp,
    required this.chunkHash,
    required this.prevBlockHash,
    required this.outcomeRoot,
    required this.prevStateRoot,
    required this.encodedMerkleRoot,
    required this.rentPaid,
    required this.validatorReward,
    required this.balanceBurnt,
    required this.outgoingReceiptsRoot,
    required this.txRoot,
    required this.signature,
    required this.validatorProposals,
  });

  final int chunkIncluded;
  final int timestamp;
  final String chunkHash;
  final String prevBlockHash;
  final String outcomeRoot;
  final String prevStateRoot;
  final String encodedMerkleRoot;
  final String rentPaid;
  final String validatorReward;
  final String balanceBurnt;
  final String outgoingReceiptsRoot;
  final String txRoot;
  final String signature;
  final List<dynamic> validatorProposals;

  factory Chunk.fromRawJson(String str) => Chunk.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chunk.fromJson(Map<String, dynamic> json) => Chunk(
    chunkIncluded: json["chunkIncluded"],
    timestamp: json["timestamp"],
    chunkHash: json["chunkHash"],
    prevBlockHash: json["prevBlockHash"],
    outcomeRoot: json["outcomeRoot"],
    prevStateRoot: json["prevStateRoot"],
    encodedMerkleRoot: json["encodedMerkleRoot"],
    rentPaid: json["rentPaid"],
    validatorReward: json["validatorReward"],
    balanceBurnt: json["balanceBurnt"],
    outgoingReceiptsRoot: json["outgoingReceiptsRoot"],
    txRoot: json["txRoot"],
    signature: json["signature"],
    validatorProposals: List<dynamic>.from(json["validatorProposals"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "chunkIncluded": chunkIncluded,
    "timestamp": timestamp,
    "chunkHash": chunkHash,
    "prevBlockHash": prevBlockHash,
    "outcomeRoot": outcomeRoot,
    "prevStateRoot": prevStateRoot,
    "encodedMerkleRoot": encodedMerkleRoot,
    "rentPaid": rentPaid,
    "validatorReward": validatorReward,
    "balanceBurnt": balanceBurnt,
    "outgoingReceiptsRoot": outgoingReceiptsRoot,
    "txRoot": txRoot,
    "signature": signature,
    "validatorProposals": List<dynamic>.from(validatorProposals.map((x) => x)),
  };
}

class Header {
  Header({
    required this.epochId,
    required this.height,
    required this.nextEpochId,
    required this.hash,
    required this.prevStateRoot,
    required this.chunkReceiptsRoot,
    required this.chunkHeadersRoot,
    required this.chunkTxRoot,
    required this.outcomeRoot,
    required this.chunkIncluded,
    required this.timestamp,
    required this.challengesRoot,
    required this.timestampNanosec,
    required this.randomValue,
    required this.gasPrice,
    required this.rentPaid,
    required this.validatorReward,
    required this.totalSupply,
    required this.lastFinalBlock,
    required this.lastDsFinalBlock,
    required this.nextBpHash,
    required this.blockMerkleRoot,
    required this.signature,
    required this.validatorProposals,
    required this.challengesResult,
    required this.approvals,
    required this.latestProtocolVersion,
  });

  final String epochId;
  final int height;
  final String nextEpochId;
  final String hash;
  final String prevStateRoot;
  final String chunkReceiptsRoot;
  final String chunkHeadersRoot;
  final String chunkTxRoot;
  final String outcomeRoot;
  final int chunkIncluded;
  final int timestamp;
  final String challengesRoot;
  final String timestampNanosec;
  final String randomValue;
  final String gasPrice;
  final String rentPaid;
  final String validatorReward;
  final String totalSupply;
  final String lastFinalBlock;
  final String lastDsFinalBlock;
  final String nextBpHash;
  final String blockMerkleRoot;
  final String signature;
  final List<dynamic> validatorProposals;
  final List<dynamic> challengesResult;
  final List<String> approvals;
  final int latestProtocolVersion;

  factory Header.fromRawJson(String str) => Header.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    epochId: json["epochId"],
    height: json["height"],
    nextEpochId: json["nextEpochId"],
    hash: json["hash"],
    prevStateRoot: json["prevStateRoot"],
    chunkReceiptsRoot: json["chunkReceiptsRoot"],
    chunkHeadersRoot: json["chunkHeadersRoot"],
    chunkTxRoot: json["chunkTxRoot"],
    outcomeRoot: json["outcomeRoot"],
    chunkIncluded: json["chunkIncluded"],
    timestamp: json["timestamp"],
    challengesRoot: json["challengesRoot"],
    timestampNanosec: json["timestampNanosec"],
    randomValue: json["randomValue"],
    gasPrice: json["gasPrice"],
    rentPaid: json["rentPaid"],
    validatorReward: json["validatorReward"],
    totalSupply: json["totalSupply"],
    lastFinalBlock: json["lastFinalBlock"],
    lastDsFinalBlock: json["lastDsFinalBlock"],
    nextBpHash: json["nextBpHash"],
    blockMerkleRoot: json["blockMerkleRoot"],
    signature: json["signature"],
    validatorProposals: List<dynamic>.from(json["validatorProposals"].map((x) => x)),
    challengesResult: List<dynamic>.from(json["challengesResult"].map((x) => x)),
    approvals: List<String>.from(json["approvals"].map((x) => x)),
    latestProtocolVersion: json["latestProtocolVersion"],
  );

  Map<String, dynamic> toJson() => {
    "epochId": epochId,
    "height": height,
    "nextEpochId": nextEpochId,
    "hash": hash,
    "prevStateRoot": prevStateRoot,
    "chunkReceiptsRoot": chunkReceiptsRoot,
    "chunkHeadersRoot": chunkHeadersRoot,
    "chunkTxRoot": chunkTxRoot,
    "outcomeRoot": outcomeRoot,
    "chunkIncluded": chunkIncluded,
    "timestamp": timestamp,
    "challengesRoot": challengesRoot,
    "timestampNanosec": timestampNanosec,
    "randomValue": randomValue,
    "gasPrice": gasPrice,
    "rentPaid": rentPaid,
    "validatorReward": validatorReward,
    "totalSupply": totalSupply,
    "lastFinalBlock": lastFinalBlock,
    "lastDsFinalBlock": lastDsFinalBlock,
    "nextBpHash": nextBpHash,
    "blockMerkleRoot": blockMerkleRoot,
    "signature": signature,
    "validatorProposals": List<dynamic>.from(validatorProposals.map((x) => x)),
    "challengesResult": List<dynamic>.from(challengesResult.map((x) => x)),
    "approvals": List<dynamic>.from(approvals.map((x) => x)),
    "latestProtocolVersion": latestProtocolVersion,
  };
}
