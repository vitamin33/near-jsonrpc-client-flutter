class SyncInfo {
  final String latestBlockHash;
  final int latestBlockHeight;
  final String latestBlockTime;
  final String latestStateRoot;
  final bool syncing;

  SyncInfo.name(this.latestBlockHash, this.latestBlockHeight,
      this.latestBlockTime, this.latestStateRoot, this.syncing);
}

class Version {
  final String version;
  final String build;

  Version.name(this.version, this.build);
}

class NodeStatusResult {
  final String chainId;
  final String rpcAddr;
  final SyncInfo syncInfo;
  final List<String> validators;
  final Version version;

  NodeStatusResult.name(this.chainId, this.rpcAddr, this.syncInfo,
      this.validators, this.version);
}

typedef BlockHash = String;
typedef BlockHeight = int;

class BlockId {
  BlockHash? blockHash;
  BlockHeight? blockHeight;

  BlockId([this.blockHash, this.blockHeight]);
}

enum Finality {
  optimistic,
  nearFinal,
  finalEnd
}
enum SyncCheckpoint {
  genesis,
  earliestAvailable,
}

class BlockReference {
  BlockId blockId;
  Finality finality;
  SyncCheckpoint syncCheckpoint;

  BlockReference(this.blockId, this.finality, this.syncCheckpoint);
}

enum ExecutionStatusBasic {
  unknown,
  pending,
  failure,
}

class ExecutionStatus {
  ExecutionStatusBasic status;
  String? successValue;
  String? successReceiptId;
  ExecutionError? failure;

  ExecutionStatus(this.status, [this.successValue, this.successReceiptId,
    this.failure]);
}

enum FinalExecutionStatusBasic {
  notStarted,
  started,
  failure,
}

class MerkleNode {
  String hash;
  String direction;

  MerkleNode(this.hash, this.direction);
}

typedef MerklePath = List<MerkleNode>;

class ExecutionError {
  String errorMessage;
  String errorType;

  ExecutionError(this.errorMessage, this.errorType);
}

class FinalExecutionStatus {
  String? successValue;
  ExecutionError? failure;
}

class ExecutionOutcomeWithId {
  String id;
  ExecutionOutcome outcome;

  ExecutionOutcomeWithId(this.id, this.outcome);
}

class ExecutionOutcome {
  List<String> logs;
  List<String> receipt_ids;
  int gasBurnt;
  ExecutionStatus status;

  ExecutionOutcome(this.logs, this.receipt_ids, this.gasBurnt, this.status);
}

class ExecutionOutcomeWithIdView {
  MerklePath proof;
  String block_hash;
  String id;
  ExecutionOutcome outcome;

  ExecutionOutcomeWithIdView(this.proof, this.block_hash, this.id,
      this.outcome);
}

class FinalExecutionOutcome {
  FinalExecutionStatus status;
  dynamic transaction;
  ExecutionOutcomeWithId transactionOutcome;
  List<ExecutionOutcomeWithId> receiptsOutcome;

  FinalExecutionOutcome(this.status, this.transaction, this.transactionOutcome,
      this.receiptsOutcome);
}

class GasPrice {
  String gasPrice;

  GasPrice(this.gasPrice);
}

class AccessKeyWithPublicKey {
  String accountId;
  String publicKey;

  AccessKeyWithPublicKey(this.accountId, this.publicKey);
}

class QueryResponseKind {
  BlockHeight blockHeight;
  BlockHash blockHash;

  QueryResponseKind(this.blockHeight, this.blockHash);
}


class ViewAccountRequest extends RpcQueryRequest {
  String requestType = 'view_account';
  String accountId;

  ViewAccountRequest(BlockReference blockReference, this.accountId) : super(blockReference);
}

class ViewCodeRequest extends RpcQueryRequest {
  String requestType = 'view_code';
  String accountId;

  ViewCodeRequest(BlockReference blockReference, this.accountId) : super(blockReference);
}

class ViewStateRequest extends RpcQueryRequest {
  String requestType = 'view_state';
  String accountId;
  String prefixBase64;

  ViewStateRequest(BlockReference blockReference, this.accountId, this.prefixBase64)
  : super(blockReference);
}

class ViewAccessKeyRequest extends RpcQueryRequest {
  String requestType = 'view_access_key';
  String accountId;
  String publicKey;

  ViewAccessKeyRequest(
      BlockReference blockReference, this.accountId, this.publicKey
      ) : super(blockReference);
}

class ViewAccessKeyListRequest extends RpcQueryRequest {
  String requestType = 'view_access_key_list';
  String accountId;

  ViewAccessKeyListRequest(BlockReference blockReference, this.accountId)
      : super(blockReference);
}

class CallFunctionRequest extends RpcQueryRequest{
  String requestType = 'call_function';
  String accountId;
  String methodBame;
  String argsBase64;

  CallFunctionRequest(
      BlockReference blockReference, this.accountId, this.methodBame, this.argsBase64
      ) : super(blockReference);
}

abstract class RpcQueryRequest {
  BlockReference blockReference;

  RpcQueryRequest(this.blockReference);
}