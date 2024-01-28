import 'package:dio/dio.dart';

class AuthService {
  static String? token;
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await Dio().post(
        // "http://10.0.2.2/tokolaravel/public/api/login",
        "http://localhost/tokolaravel/public/api/login",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "email": email,
          "password": password,
        },
      );
      Map obj = response.data;
      if (obj["success"] == false) return false;

      token = obj["data"]["token"];
      return true;
    } on Exception catch (_) {
      return false;
    }
    
  }
}

class AuthService1 {
  static String? token;
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var response = await Dio().post(
        // "http://10.0.2.2/tokolaravel/public/api/login",
        "http://localhost/tokolaravel/public/api/register",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
      Map obj = response.data;
      if (obj["success"] == false) return false;

      token = obj["data"]["token"];
      return true;
    } on Exception catch (_) {
      return false;
    }
    
  }
}
