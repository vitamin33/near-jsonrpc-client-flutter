import 'dart:io';

import 'package:http/http.dart' as http;

class JsonRpcClient {

  final String serverUrl;

  JsonRpcClient(this.serverUrl);

  JsonRpcClient connect(String serverUrl) {
    return JsonRpcClient(serverUrl);
  }
}