import 'dart:ffi';

import 'package:near_jsonrpc_client/struct/transaction/transactions.dart';

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

  NodeStatusResult.name(
      this.chainId, this.rpcAddr, this.syncInfo, this.validators, this.version);
}

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

  ExecutionStatus(this.status,
      [this.successValue, this.successReceiptId, this.failure]);
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

  ExecutionOutcomeWithIdView(
      this.proof, this.block_hash, this.id, this.outcome);
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

class BlockResult {
  String author;
  BlockHeader header;
  List<Chunk> chunks;

  BlockResult(this.author, this.header, this.chunks);
}

class BlockChange {
  String type;
  String accountId;

  BlockChange(this.type, this.accountId);
}

class BlockChangeResult {
  String blockHash;
  List<BlockChange> changes;

  BlockChangeResult(this.blockHash, this.changes);
}

class ChangeResult {
  String blockHash;
  Array<dynamic> changes;

  ChangeResult(this.blockHash, this.changes);
}

class BlockHeader {
  int height;
  String epochId;
  String nextEpochId;
  String hash;
  String prevHash;
  String prevStateRoot;
  String chunkReceiptsRoot;
  String chunkHeadersRoot;
  String chunkTxRoot;
  String outcomeRoot;
  int chunkIncluded;
  String challengesRoot;
  int timestamp;
  String timestampNanosec;
  String randomValue;
  Array<dynamic> validatorProposals;
  List<bool> chunkMask;
  String gasPrice;
  String rentPaid;
  String validatorReward;
  String totalSupply;
  Array<dynamic> challengesResult;
  String lastFinalBlock;
  String lastDsFinalBlock;
  String nextBpHash;
  String blockMerkleRoot;
  List<String> approvals;
  String signature;
  int latestProtocolVersion;

  BlockHeader(
      this.height,
      this.epochId,
      this.nextEpochId,
      this.hash,
      this.prevHash,
      this.prevStateRoot,
      this.chunkReceiptsRoot,
      this.chunkHeadersRoot,
      this.chunkTxRoot,
      this.outcomeRoot,
      this.chunkIncluded,
      this.challengesRoot,
      this.timestamp,
      this.timestampNanosec,
      this.randomValue,
      this.validatorProposals,
      this.chunkMask,
      this.gasPrice,
      this.rentPaid,
      this.validatorReward,
      this.totalSupply,
      this.challengesResult,
      this.lastFinalBlock,
      this.lastDsFinalBlock,
      this.nextBpHash,
      this.blockMerkleRoot,
      this.approvals,
      this.signature,
      this.latestProtocolVersion);
}

typedef ShardId = int;

abstract class ChunkId {}

class BlockShardId extends ChunkId {
  BlockId blockId;
  ShardId shardId;

  BlockShardId(this.blockId, this.shardId);
}

class ChunkHash extends ChunkId {
  String chunkHash;

  ChunkHash(this.chunkHash);
}

class ChunkHeader {
  String balanceBurnt;
  ChunkHash chunkHash;
  int encodedLength;
  String encodedMerkleRoot;
  int gasLimit;
  int gasUsed;
  int heightCreated;
  int heightIncluded;
  String outgoingReceiptsRoot;
  String prevBlockHash;
  int prevStateNumParts;
  String prevStateRootHash;
  String rentPaid;
  int shardId;
  String signature;
  String txRoot;
  Array<dynamic> validatorProposals;
  String validatorReward;

  ChunkHeader(
      this.balanceBurnt,
      this.chunkHash,
      this.encodedLength,
      this.encodedMerkleRoot,
      this.gasLimit,
      this.gasUsed,
      this.heightCreated,
      this.heightIncluded,
      this.outgoingReceiptsRoot,
      this.prevBlockHash,
      this.prevStateNumParts,
      this.prevStateRootHash,
      this.rentPaid,
      this.shardId,
      this.signature,
      this.txRoot,
      this.validatorProposals,
      this.validatorReward);
}

class ChunkResult {
  ChunkHeader header;
  Array<dynamic> receipts;
  List<Transaction> transactions;

  ChunkResult(this.header, this.receipts, this.transactions);
}

class Chunk {
  String chunkHash;
  String prevBlockHash;
  String outcomeRoot;
  String prevStateRoot;
  String encodedMerkleRoot;
  int encodedLength;
  int heightCreated;
  int heightIncluded;
  int shardId;
  int gasUsed;
  int gasLimit;
  String rentPaid;
  String validatorReward;
  String balanceBurnt;
  String outgoingReceiptsRoot;
  String txRoot;
  Array<dynamic> validatorProposals;
  String signature;

  Chunk(
      this.chunkHash,
      this.prevBlockHash,
      this.outcomeRoot,
      this.prevStateRoot,
      this.encodedMerkleRoot,
      this.encodedLength,
      this.heightCreated,
      this.heightIncluded,
      this.shardId,
      this.gasUsed,
      this.gasLimit,
      this.rentPaid,
      this.validatorReward,
      this.balanceBurnt,
      this.outgoingReceiptsRoot,
      this.txRoot,
      this.validatorProposals,
      this.signature);
}

class CurrentEpochValidatorInfo {
  String accountId;
  String publicKey;
  bool isSlashed;
  String stake;
  List<int> shards;
  int numProducedBlocks;
  int numExpectedBlocks;

  CurrentEpochValidatorInfo(this.accountId, this.publicKey, this.isSlashed,
      this.stake, this.shards, this.numProducedBlocks, this.numExpectedBlocks);
}

class NextEpochValidatorInfo {
  String accountId;
  String publicKey;
  String stake;
  List<int> shards;

  NextEpochValidatorInfo(
      this.accountId, this.publicKey, this.stake, this.shards);
}

class ValidatorStakeView {
  String accountId;
  String publicKey;
  String stake;

  ValidatorStakeView(this.accountId, this.publicKey, this.stake);
}

class NearProtocolConfig {
  NearProtocolRuntimeConfig runtimeConfig;

  NearProtocolConfig(this.runtimeConfig);
}

class NearProtocolRuntimeConfig {
  String storageAmountPerByte;

  NearProtocolRuntimeConfig(this.storageAmountPerByte);
}

class EpochValidatorInfo {
// Validators for the current epoch.
  List<NextEpochValidatorInfo> nextValidators;

// Validators for the next epoch.
  List<CurrentEpochValidatorInfo> currentValidators;

// Fishermen for the current epoch.
  List<ValidatorStakeView> nextFisherman;

// Fishermen for the next epoch.
  List<ValidatorStakeView> currentFisherman;

// Proposals in the current epoch.
  List<ValidatorStakeView> currentProposals;

// Kickout in the previous epoch.
  List<ValidatorStakeView> prevEpochKickout;

// Epoch start height.
  int epochStartHeight;

  EpochValidatorInfo(
      this.nextValidators,
      this.currentValidators,
      this.nextFisherman,
      this.currentFisherman,
      this.currentProposals,
      this.prevEpochKickout,
      this.epochStartHeight);
}

class LightClientProof {
  ExecutionOutcomeWithIdView outcomeProof;
  MerklePath outcomeRootProof;
  LightClientBlockLiteView blockHeaderLite;
  MerklePath blockProof;

  LightClientProof(this.outcomeProof, this.outcomeRootProof,
      this.blockHeaderLite, this.blockProof);
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
