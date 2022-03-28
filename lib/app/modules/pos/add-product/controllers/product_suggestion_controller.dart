import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/contract.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/customer.dart';
import 'package:posdelivery/models/response/pos/customer_list_response.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/pos/product_suggestion_response.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

class ProductSuggestionController extends BaseGetXController
    implements IProductSuggestionController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();
  RxList<Product> productList = RxList([]);
  RxList<CustomerInfo> customerList = RxList([]);

  @override
  void onInit() {
    posDataProvider.pSujCtrl = this;
    super.onInit();
  }

  RxString searchTerm = RxString('');

  actionLoadingSearch(String search) {
    posDataProvider.getProductSuggestion(search);
  }

  actionLoadingSearchCustomer(String search) {
    posDataProvider.getCustomerSearch(search);
  }

  @override
  onSuggestionDone(ProductSuggestionResponse pResponse) {
    productList.value = pResponse.products!;
  }

  actionSelectProduct(Product product) async {
    //UINotification.showLoading();
    //await Future.delayed(Constants.oneSecDuration);
  }

  @override
  onSuggestionError(ErrorMessage err) {}

  @override
  onCustomerSuggestionDone(CustomerListResponse customerListResponse) {
    customerList.value = customerListResponse.customers!;
  }

  @override
  onCustomerSuggestionError(ErrorMessage err) {}
}
