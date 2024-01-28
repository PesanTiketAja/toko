import 'package:hyper_ui/core.dart';

class ProductService {
  Future<List> getProduct() async {
    // dio_get
    var response = await Dio().get(
      // "http://10.0.2.2/tokolaravel/public/api/products",
      "http://localhost/tokolaravel/public/api/products",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
    );
    Map obj = response.data;
    return obj['data'];
  }

  Future insertProduct({
    required String productName,
    required double price,
    required String category,
    required String description,
  }) async {
    var response = await Dio().post(
      // "http://10.0.2.2/tokolaravel/public/api/products",
      "http://localhost/tokolaravel/public/api/products",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
      data: {
        "product_name": productName,
        "price": price,
        "category": category,
        "description": description,
      },
    );
    // ignore: unused_local_variable
    Map obj = response.data;
    return obj['data']["id"];
  }

  Future updateProduct({
    required String id,
    required String productName,
    required double price,
    required String category,
    required String description,
  }) async {
    var response = await Dio().put(
      // "http://10.0.2.2/tokolaravel/public/api/products/$id",
      "http://localhost/tokolaravel/public/api/products/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
      data: {
        "product_name": productName,
        "price": price,
        "category": category,
        "description": description,
      },
    );
    // ignore: unused_local_variable
    Map obj = response.data;
    return obj['data']["id"];
  }

  Future deleteProduct(int id) async {
    var response = await Dio().delete(
      // "http://10.0.2.2/tokolaravel/public/api/products/$id",
      "http://localhost/tokolaravel/public/api/products/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
    );
    print(response.statusCode);
  }

  Future getProductByID(int id) async {
    var response = await Dio().get(
      // "http://10.0.2.2/tokolaravel/public/api/products/$id",
      "http://localhost/tokolaravel/public/api/products/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AuthService.token}",
        },
      ),
    );
    Map obj = response.data;
    return obj['data'];
  }
}
