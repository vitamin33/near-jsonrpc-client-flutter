// To parse this JSON data, do
//
//     final chunkResult = chunkResultFromJson(jsonString);

import 'dart:convert';

class ChunkResult {
  ChunkResult({
    required this.header,
    required this.receipts,
    required this.transactions,
  });

  final Header header;
  final List<Receipt> receipts;
  final List<Transaction> transactions;

  factory ChunkResult.fromRawJson(String str) => ChunkResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChunkResult.fromJson(Map<String, dynamic> json) => ChunkResult(
    header: Header.fromJson(json["header"]),
    receipts: List<Receipt>.from(json["receipts"].map((x) => Receipt.fromJson(x))),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header": header.toJson(),
    "receipts": List<dynamic>.from(receipts.map((x) => x.toJson())),
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Header {
  Header({
    required this.balanceBurnt,
    required this.chunkHash,
    required this.encodedMerkleRoot,
    required this.encodedLength,
    required this.gasLimit,
    required this.gasUsed,
    required this.heightCreated,
    required this.heightIncluded,
    required this.outgoingReceiptsRoot,
    required this.prevBlockHash,
    required this.prevStateRootHash,
    required this.rentPaid,
    required this.prevStateNumParts,
    required this.shardId,
    required this.signature,
    required this.txRoot,
    required this.validatorReward,
    required this.validatorProposals,
  });

  final String balanceBurnt;
  final ChunkHash chunkHash;
  final String encodedMerkleRoot;
  final int encodedLength;
  final int gasLimit;
  final int gasUsed;
  final int heightCreated;
  final int heightIncluded;
  final String outgoingReceiptsRoot;
  final String prevBlockHash;
  final String prevStateRootHash;
  final String rentPaid;
  final int prevStateNumParts;
  final int shardId;
  final String signature;
  final String txRoot;
  final String validatorReward;
  final List<String> validatorProposals;

  factory Header.fromRawJson(String str) => Header.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    balanceBurnt: json["balanceBurnt"],
    chunkHash: ChunkHash.fromJson(json["chunkHash"]),
    encodedMerkleRoot: json["encodedMerkleRoot"],
    encodedLength: json["encodedLength"],
    gasLimit: json["gasLimit"],
    gasUsed: json["gasUsed"],
    heightCreated: json["heightCreated"],
    heightIncluded: json["heightIncluded"],
    outgoingReceiptsRoot: json["outgoingReceiptsRoot"],
    prevBlockHash: json["prevBlockHash"],
    prevStateRootHash: json["prevStateRootHash"],
    rentPaid: json["rentPaid"],
    prevStateNumParts: json["prevStateNumParts"],
    shardId: json["shardId"],
    signature: json["signature"],
    txRoot: json["txRoot"],
    validatorReward: json["validatorReward"],
    validatorProposals: List<String>.from(json["validatorProposals"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "balanceBurnt": balanceBurnt,
    "chunkHash": chunkHash.toJson(),
    "encodedMerkleRoot": encodedMerkleRoot,
    "encodedLength": encodedLength,
    "gasLimit": gasLimit,
    "gasUsed": gasUsed,
    "heightCreated": heightCreated,
    "heightIncluded": heightIncluded,
    "outgoingReceiptsRoot": outgoingReceiptsRoot,
    "prevBlockHash": prevBlockHash,
    "prevStateRootHash": prevStateRootHash,
    "rentPaid": rentPaid,
    "prevStateNumParts": prevStateNumParts,
    "shardId": shardId,
    "signature": signature,
    "txRoot": txRoot,
    "validatorReward": validatorReward,
    "validatorProposals": List<dynamic>.from(validatorProposals.map((x) => x)),
  };
}

class ChunkHash {
  ChunkHash({
    required this.chunkHash,
  });

  final String chunkHash;

  factory ChunkHash.fromRawJson(String str) => ChunkHash.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChunkHash.fromJson(Map<String, dynamic> json) => ChunkHash(
    chunkHash: json["chunkHash"],
  );

  Map<String, dynamic> toJson() => {
    "chunkHash": chunkHash,
  };
}

class Receipt {
  Receipt();

  factory Receipt.fromRawJson(String str) => Receipt.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Transaction {
  Transaction({
    required this.signerId,
    required this.publicKey,
    required this.nonce,
    required this.receiverId,
    required this.actions,
    required this.blockHash,
  });

  final String signerId;
  final PublicKey publicKey;
  final int nonce;
  final String receiverId;
  final List<String> actions;
  final String blockHash;

  factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    signerId: json["signerId"],
    publicKey: PublicKey.fromJson(json["publicKey"]),
    nonce: json["nonce"],
    receiverId: json["receiverId"],
    actions: List<String>.from(json["actions"].map((x) => x)),
    blockHash: json["blockHash"],
  );

  Map<String, dynamic> toJson() => {
    "signerId": signerId,
    "publicKey": publicKey.toJson(),
    "nonce": nonce,
    "receiverId": receiverId,
    "actions": List<dynamic>.from(actions.map((x) => x)),
    "blockHash": blockHash,
  };
}

class PublicKey {
  PublicKey({
    required this.data,
    required this.keyType,
  });

  final String data;
  final String keyType;

  factory PublicKey.fromRawJson(String str) => PublicKey.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PublicKey.fromJson(Map<String, dynamic> json) => PublicKey(
    data: json["data"],
    keyType: json["keyType"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "keyType": keyType,
  };
}
