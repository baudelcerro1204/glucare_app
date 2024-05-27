import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<void> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al registrar usuario: ${response.body}');
    }
  }

  Future<http.Response> _getRequest(String url, Map<String, String> params, String apiKey, String apiSecret) async {
    final method = 'GET';
    final oauthNonce = _generateNonce(32);
    final oauthTimestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

    params.addAll({
      'oauth_consumer_key': apiKey,
      'oauth_nonce': oauthNonce,
      'oauth_signature_method': 'HMAC-SHA1',
      'oauth_timestamp': oauthTimestamp,
      'oauth_version': '1.0',
    });

    final signature = _generateSignature(method, url, params, apiSecret);
    params['oauth_signature'] = signature;

    final uri = Uri.parse(url).replace(queryParameters: params);
    return await http.get(uri);
  }

  Future<http.Response> searchFood(String query, String apiKey, String apiSecret) async {
    final url = 'https://platform.fatsecret.com/rest/server.api';
    final params = {
      'method': 'foods.search',
      'format': 'json',
      'search_expression': query,
    };
    return await _getRequest(url, params, apiKey, apiSecret);
  }

  String _generateNonce(int length) {
    final _random = Random();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => _chars[_random.nextInt(_chars.length)]).join();
  }

  String _generateSignature(String method, String url, Map<String, String> params, String secret) {
    final sortedParams = params.keys.toList()..sort();
    final paramString = sortedParams.map((key) => '$key=${Uri.encodeQueryComponent(params[key]!)}').join('&');
    final baseString = '$method&${Uri.encodeComponent(url)}&${Uri.encodeComponent(paramString)}';
    final signingKey = '$secret&';
    final hmacSha1 = Hmac(sha1, utf8.encode(signingKey));
    final signature = hmacSha1.convert(utf8.encode(baseString));
    return base64.encode(signature.bytes);
  }
}
