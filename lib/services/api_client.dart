import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client client;
  final Future<String?> Function()? tokenProvider;
  ApiClient({this.baseUrl = 'http://10.0.2.2:8000', http.Client? client, this.tokenProvider}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final token = await tokenProvider?.call();
    final headers = <String, String>{'content-type': 'application/json', if (token != null) 'authorization': 'Bearer $token'};
    final response = await client.post(Uri.parse('$baseUrl$path'), headers: headers, body: jsonEncode(body));
    if (response.statusCode < 200 || response.statusCode >= 300) throw Exception('Request failed (${response.statusCode})');
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
  Future<Map<String, dynamic>> get(String path) async {
    final token = await tokenProvider?.call();
    final response = await client.get(Uri.parse('$baseUrl$path'), headers: {if (token != null) 'authorization': 'Bearer $token'});
    if (response.statusCode < 200 || response.statusCode >= 300) throw Exception('Request failed (${response.statusCode})');
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
