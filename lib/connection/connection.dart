import 'package:near_jsonrpc_client/connection/signer.dart';
import '../provider.dart';


// Connects an account to a given network via a given provider
class Connection {
  final String networkId;
  final Provider provider;
  final Signer signer;

  // // @param config Contains connection info details
  // static Connection fromConfig(dynamic config) {
  //  return Connection();
  // }

  Connection(this.networkId, this.provider, this.signer);
}