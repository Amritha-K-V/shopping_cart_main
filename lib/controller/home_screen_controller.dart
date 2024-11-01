
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_main/model/product_screen_model.dart';

class HomeScreenController with ChangeNotifier {
  List<ProductsModel> product= [];
  int selectedcategoryIndex = 0;
  bool isLoading = false;
  bool isProductsLoading = false;
  List categoriesList = ["All"]; //to store categories form api

  Future<void> getCategories() async {
    categoriesList = ["All"];
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/categories");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        categoriesList.addAll(jsonDecode(response.body));
        log(categoriesList.toString());
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void onCategorySelection(int index) {
    selectedcategoryIndex = index;
    notifyListeners();
    if(selectedcategoryIndex == 0){
      getAllProducts();
    }else{
      getProductsByCategory(categoriesList[selectedcategoryIndex]);
    }
  }

  Future<void> getAllProducts() async {
    isProductsLoading = true;
    final url = Uri.parse("https://fakestoreapi.com/products");
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        product = productsModelFromJson(response.body);

      }

    }catch(e){
print(e);
    }
    isProductsLoading = false;
notifyListeners();
  }

  Future<void> getProductsByCategory(String category) async {
     
    isProductsLoading = true;
    final url = Uri.parse("https://fakestoreapi.com/products/category/$category");
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        product = productsModelFromJson(response.body);

      }

    }catch(e){
print(e);
    }
    isProductsLoading = false;
notifyListeners();
  }

  }

