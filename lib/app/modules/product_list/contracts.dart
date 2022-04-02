import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/error_message.dart';

abstract class IProductListController {
  onWProductOffListDone(List<WarehouseProductsResponse> wPrdtListRes);
  onWProductOffListError(ErrorMessage err);
}
