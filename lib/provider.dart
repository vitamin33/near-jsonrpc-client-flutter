import 'package:near_jsonrpc_client/struct/responses.dart';
import 'package:near_jsonrpc_client/struct/transaction/transactions.dart';

abstract class Provider {
  Future<NodeStatusResult> status();

  Future<FinalExecutionOutcome> sendTransaction(SignedTransaction signedTransaction);
  //sendTransactionAsync(signedTransaction: SignedTransaction): Promise<FinalExecutionOutcome>;

  Future<FinalExecutionOutcome> txStatus(String txHash, String accountId);
  Future<FinalExecutionOutcome> txStatusReceipts(String txHash, String accountId);
  Future<T> query<T extends QueryResponseKind>(RpcQueryRequest params);

  Future<T> queryWithPath<T extends QueryResponseKind>(String path, String data);

  // // TODO: BlockQuery type?
  Future<BlockResult> block(BlockId blockId);
  Future<BlockResult> blockWithReference(BlockReference blockReference);
  Future<BlockChangeResult> blockChangesWithReference(BlockReference blockReference);
  Future<BlockChangeResult> blockChanges(BlockId blockId);
  Future<ChunkResult> chunk(ChunkId chunkId);

  // // TODO: Use BlockQuery?
  Future<EpochValidatorInfo> validators(BlockId blockId);
  // abstract experimental_genesisConfig(): Promise<NearProtocolConfig>;
  // abstract experimental_protocolConfig(blockReference: BlockReference): Promise<NearProtocolConfig>;
  // abstract lightClientProof(request: LightClientProofRequest): Promise<LightClientProof>;
  // abstract gasPrice(blockId: BlockId): Promise<GasPrice>;
}