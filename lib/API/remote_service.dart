import 'package:fancy/API/productlist.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Products>?> getData() async {
    var client = http.Client();
    var uri = Uri.parse('https://63f1d598aab7d09125fc4e75.mockapi.io/products');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body.toString();
      return productsFromJson(json);
    } else {
      return null;
    }
  }
}
