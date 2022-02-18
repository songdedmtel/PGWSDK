import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:http/http.dart' as http;
import 'package:pgw_sdk_example/api/interfaces/i_repository.dart';
import 'package:pgw_sdk_example/api/repositories/constant_repository.dart';

class PaymentTokenRepository implements IRepository {
  String? _payload;

  @override
  Future<String?> execute() async {
    if (_payload == null) throw 'Please set request before execute';

    final response = await http.post(
      Uri.parse('https://sandbox-pgw.2c2p.com/payment/4.1/PaymentToken'),
      headers: {
        HttpHeaders.acceptHeader: 'text/plain',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: _payload,
    );

    /// Decode reponse to json.
    final responseJson = jsonDecode(response.body);

    // Log
    dev.log('response body = $responseJson');
    try {
      // Verify a token
      final jwt = JWT.verify(responseJson['payload'], SecretKey(ConstantRepository.SECRET_KEY));

      // Log
      dev.log('Payload: ${jwt.payload}');

      // Return paymentToken
      return jwt.payload['paymentToken'];
    } on JWTExpiredError {
      dev.log('jwt expired');
      return null;
    } on JWTError catch (ex) {
      dev.log(ex.message); // ex: invalid signature
      return null;
    }
  }

  PaymentTokenRepository setRequest(Map<String, Object> jsonRequest) {
    dev.log('do request => $jsonRequest');

    final jwtJson = JWT(jsonRequest, header: {"alg": "HS256", "typ": "JWT"});
    final jwtRequest = jwtJson.sign(SecretKey(ConstantRepository.SECRET_KEY));

    // Set payload
    _payload = jsonEncode({
      'payload': jwtRequest,
    });
    return this;
  }
}
