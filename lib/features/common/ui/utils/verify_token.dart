import 'package:jwt_decoder/jwt_decoder.dart';

bool verifyToken(String? token) {
  if (token == null) {
    return false;
  } else {
    bool isExpired = JwtDecoder.isExpired(token);
    return !isExpired;
  }
}
