import 'package:posdelivery/models/response/pos/product.dart';

class ProductSuggestionResponse {
  List<Product>? products;
  ProductSuggestionResponse();
  ProductSuggestionResponse.fromJSON(List<dynamic> parsedJson) {
    products = (parsedJson)
        .map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        .cast<Product>()
        .toList();
  }
}
