import 'dart:ffi';

typedef BlockHash = String;
typedef BlockHeight = int;

class BlockId {
  BlockHash? blockHash;
  BlockHeight? blockHeight;

  BlockId([this.blockHash, this.blockHeight]);
}

enum Finality { optimistic, nearFinal, finalEnd }
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

  ViewAccountRequest(BlockReference blockReference, this.accountId)
      : super(blockReference);
}

class ViewCodeRequest extends RpcQueryRequest {
  String requestType = 'view_code';
  String accountId;

  ViewCodeRequest(BlockReference blockReference, this.accountId)
      : super(blockReference);
}

class ViewStateRequest extends RpcQueryRequest {
  String requestType = 'view_state';
  String accountId;
  String prefixBase64;

  ViewStateRequest(
      BlockReference blockReference, this.accountId, this.prefixBase64)
      : super(blockReference);
}

class ViewAccessKeyRequest extends RpcQueryRequest {
  String requestType = 'view_access_key';
  String accountId;
  String publicKey;

  ViewAccessKeyRequest(
      BlockReference blockReference, this.accountId, this.publicKey)
      : super(blockReference);
}

class ViewAccessKeyListRequest extends RpcQueryRequest {
  String requestType = 'view_access_key_list';
  String accountId;

  ViewAccessKeyListRequest(BlockReference blockReference, this.accountId)
      : super(blockReference);
}

class CallFunctionRequest extends RpcQueryRequest {
  String requestType = 'call_function';
  String accountId;
  String methodBame;
  String argsBase64;

  CallFunctionRequest(BlockReference blockReference, this.accountId,
      this.methodBame, this.argsBase64)
      : super(blockReference);
}

abstract class RpcQueryRequest {
  BlockReference blockReference;

  RpcQueryRequest(this.blockReference);
}

/////////

class ChangeResult {
  String blockHash;
  Array<dynamic> changes;

  ChangeResult(this.blockHash, this.changes);
}

typedef ShardId = int;

abstract class ChunkId {}

class BlockShardId extends ChunkId {
  BlockId blockId;
  ShardId shardId;

  BlockShardId(this.blockId, this.shardId);
}

class BlockHeaderInnerLiteView {
  int height;
  String epochId;
  String nextEpochId;
  String prevStateRoot;
  String outcomeRoot;
  int timestamp;
  String nextBpHash;
  String blockMerkleRoot;

  BlockHeaderInnerLiteView(
      this.height,
      this.epochId,
      this.nextEpochId,
      this.prevStateRoot,
      this.outcomeRoot,
      this.timestamp,
      this.nextBpHash,
      this.blockMerkleRoot);
}

class LightClientBlockLiteView {
  String prevBlockHash;
  String innerRestHash;
  BlockHeaderInnerLiteView innerLite;

  LightClientBlockLiteView(
      this.prevBlockHash, this.innerRestHash, this.innerLite);
}

enum IdType {
  transaction,
  receipt,
}

class LightClientProofRequest {
  IdType type;
  String lightClientHead;
  String? transactionHash;
  String? senderId;
  String? receiptId;
  String? receiverId;

  LightClientProofRequest(this.type, this.lightClientHead, this.transactionHash,
      this.senderId, this.receiptId, this.receiverId);
}

class FunctionCall {
  String allowance;
  String receiverId;
  List<String> methodNames;

  FunctionCall(this.allowance, this.receiverId, this.methodNames);
}

class FunctionCallPermissionView {
  FunctionCall functionCall;

  FunctionCallPermissionView(this.functionCall);
}

class AccessKeyView extends QueryResponseKind {
  int nonce;
  FunctionCallPermissionView permission;

  AccessKeyView(
      BlockHeight blockHeight, BlockHash blockHash, this.nonce, this.permission)
      : super(blockHeight, blockHash);
}

class AccessKeyInfoView {
  String publicKey;
  AccessKeyView accessKey;

  AccessKeyInfoView(this.publicKey, this.accessKey);
}

class AccessKeyList extends QueryResponseKind {
  List<AccessKeyInfoView> keys;

  AccessKeyList(BlockHeight blockHeight, BlockHash blockHash, this.keys)
      : super(blockHeight, blockHash);
}

class AccountView extends QueryResponseKind {
  String amount;
  String locked;
  String codeHash;
  String storageUsage;
  BlockHeight storagePaidAt;

  AccountView(BlockHeight blockHeight, BlockHash blockHash, this.amount,
      this.locked, this.codeHash, this.storageUsage, this.storagePaidAt)
      : super(blockHeight, blockHash);
}


class MaybeError {
  String errorMessage;

  MaybeError(this.errorMessage);
}