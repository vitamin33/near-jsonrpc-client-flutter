// To parse this JSON data, do
//
//     final finalExecutionOutcome = finalExecutionOutcomeFromJson(jsonString);

import 'dart:convert';

class FinalExecutionOutcome {
  FinalExecutionOutcome({
    required this.status,
    required this.transaction,
    required this.transactionOutcome,
    required this.receiptsOutcome,
  });

  final FinalExecutionOutcomeStatus status;
  final Transaction transaction;
  final TransactionOutcome transactionOutcome;
  final List<TransactionOutcome> receiptsOutcome;

  factory FinalExecutionOutcome.fromRawJson(String str) => FinalExecutionOutcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FinalExecutionOutcome.fromJson(Map<String, dynamic> json) => FinalExecutionOutcome(
    status: FinalExecutionOutcomeStatus.fromJson(json["status"]),
    transaction: Transaction.fromJson(json["transaction"]),
    transactionOutcome: TransactionOutcome.fromJson(json["transactionOutcome"]),
    receiptsOutcome: List<TransactionOutcome>.from(json["receiptsOutcome"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "transaction": transaction.toJson(),
    "transactionOutcome": transactionOutcome.toJson(),
    "chunks": List<dynamic>.from(receiptsOutcome.map((x) => x)),
  };
}

class FinalExecutionOutcomeStatus {
  FinalExecutionOutcomeStatus({
    required this.successValue,
    required this.failure,
  });

  final String successValue;
  final Failure failure;

  factory FinalExecutionOutcomeStatus.fromRawJson(String str) => FinalExecutionOutcomeStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FinalExecutionOutcomeStatus.fromJson(Map<String, dynamic> json) => FinalExecutionOutcomeStatus(
    successValue: json["successValue"],
    failure: Failure.fromJson(json["failure"]),
  );

  Map<String, dynamic> toJson() => {
    "successValue": successValue,
    "failure": failure.toJson(),
  };
}

class Failure {
  Failure({
    required this.errorMessage,
    required this.errorType,
  });

  final String errorMessage;
  final String errorType;

  factory Failure.fromRawJson(String str) => Failure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
    errorMessage: json["errorMessage"],
    errorType: json["errorType"],
  );

  Map<String, dynamic> toJson() => {
    "errorMessage": errorMessage,
    "errorType": errorType,
  };
}

class Transaction {
  Transaction();

  factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
  );

  Map<String, dynamic> toJson() => {
  };
}

class TransactionOutcome {
  TransactionOutcome({
    required this.id,
    required this.outcome,
  });

  final String id;
  final Outcome outcome;

  factory TransactionOutcome.fromRawJson(String str) => TransactionOutcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionOutcome.fromJson(Map<String, dynamic> json) => TransactionOutcome(
    id: json["id"],
    outcome: Outcome.fromJson(json["outcome"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
  final Failure status;

  factory OutcomeStatus.fromRawJson(String str) => OutcomeStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OutcomeStatus.fromJson(Map<String, dynamic> json) => OutcomeStatus(
    successValue: json["successValue"],
    successReceiptId: json["successReceiptId"],
    status: Failure.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "successValue": successValue,
    "successReceiptId": successReceiptId,
    "status": status.toJson(),
  };
}
