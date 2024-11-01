import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_main/model/product_screen_model.dart';

class ProductDetailsController with ChangeNotifier{
  bool isLoading = false;
      ProductsModel? productDetails;

  getProductDetails(productId) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/$productId");
    try{
    var res = await http.get(url);
    if(res.statusCode == 200){
productDetails = productsDetailsModelFromJson(res.body);
    }
    }catch(e){
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}