import 'package:api_sukma/models/product_model.dart';
import 'package:api_sukma/models/profile_model.dart';
import 'package:http/http.dart' show Client;

class ApiService {
//ini url api
  final String baseUrl = "http://api.bengkelrobot.net:8001";
  final String baseUrlProduct = "https://fakestoreapi.com";

  Client client = Client();

//untuk get data
  Future<List<Profile>> getProfiles() async {
    final response = await client.get(Uri.parse("$baseUrl/api/profile"));
    if (response.statusCode == 200) {
    print(response.body);
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

//untuk add data
  Future<bool> createProfile(Profile data) async {
    final response = await client.post(
      Uri.parse("$baseUrl/api/profile"),
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

//untuk update data
  Future<bool> updateProfile(Profile data) async {
    final response = await client.put(
      Uri.parse("$baseUrl/api/profile/${data.id}"),
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

//untuk hapus data
  Future<bool> deleteProfile(int id) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/api/profile/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  //get produk
  ////untuk get data
  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse("$baseUrlProduct/products"));
    if (response.statusCode == 200) {
    print(response.body);
      return productFromJson(response.body);
    } else {
      return null;
    }
  }

//untuk add data
  Future<bool> createProduct(Product data) async {
    final response = await client.post(
      Uri.parse("$baseUrlProduct/products"),
      headers: {"content-type": "application/json"},
      body: productToJson(data),
    );
    print(response);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

//untuk update data
  Future<bool> updateProduct(Product data) async {
    final response = await client.put(
      Uri.parse("$baseUrlProduct/products/${data.id}"),
      headers: {"content-type": "application/json"},
      body: productToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

//untuk hapus data
  Future<bool> deleteProduct(int id) async {
    final response = await client.delete(
      Uri.parse("$baseUrlProduct/products/$id"),
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
