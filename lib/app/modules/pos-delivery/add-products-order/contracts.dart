import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';

abstract class IDeliveryAddProductsOrderScreenController {
  onProductDone(Product productRes);
  onProductError(ErrorMessage err);
}
