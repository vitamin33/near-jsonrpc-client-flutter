import 'package:near_jsonrpc_client/struct/responses.dart';

abstract class Provider {
  Future<NodeStatusResult> status();

  Future<FinalExecutionOutcome> sendTransaction(SignedTransaction signedTransaction);


  // abstract sendTransactionAsync(signedTransaction: SignedTransaction): Promise<FinalExecutionOutcome>;
  // abstract txStatus(txHash: Uint8Array | string, accountId: string): Promise<FinalExecutionOutcome>;
  // abstract txStatusReceipts(txHash: Uint8Array, accountId: string): Promise<FinalExecutionOutcome>;
  // abstract query<T extends QueryResponseKind>(params: RpcQueryRequest): Promise<T>;
  // abstract query<T extends QueryResponseKind>(path: string, data: string): Promise<T>;
  // // TODO: BlockQuery type?
  // abstract block(blockQuery: BlockId | BlockReference): Promise<BlockResult>;
  // abstract blockChanges(blockQuery: BlockId | BlockReference): Promise<BlockChangeResult>;
  // abstract chunk(chunkId: ChunkId): Promise<ChunkResult>;
  // // TODO: Use BlockQuery?
  // abstract validators(blockId: BlockId): Promise<EpochValidatorInfo>;
  // abstract experimental_genesisConfig(): Promise<NearProtocolConfig>;
  // abstract experimental_protocolConfig(blockReference: BlockReference): Promise<NearProtocolConfig>;
  // abstract lightClientProof(request: LightClientProofRequest): Promise<LightClientProof>;
  // abstract gasPrice(blockId: BlockId): Promise<GasPrice>;
}