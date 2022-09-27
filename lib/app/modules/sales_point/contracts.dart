import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/desktop/customer_group.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/pos/add_sale_response.dart';
import 'package:posdelivery/models/response/pos/invoice_response.dart';

import '../../../models/response/desktop/warehouse_list.dart';
import '../../../models/response/error_message.dart';

abstract class ISalesPointController {
  onCustomerOffListDone(List<CustomerListOffResponse> cListRes);
  onCustomerOffListError(ErrorMessage err);
  onWarehouseOffListDone(List<WarehouseListResponse> wListRes);
  onWarehouseOffListError(ErrorMessage err);
  onWProductOffListDone(List<WarehouseProductsResponse> wPrdtListRes);
  onWProductOffListError(ErrorMessage err);
  onCustomerGrpOffListDone(List<CustomerGroupResponse> cGrpRes);
  onCustomerGrpOffListError(ErrorMessage err);
  actionOnSaveRequest();
  onCustomerAddDone(CustomerAddResponse customerAddResponse);
  onCustomerAddError(ErrorMessage err);
  onSaleDone(AddSaleResponse addSaleResponse);
  onSaleError(ErrorMessage err);
  onSaleViewFetchDone(InvoiceResponse res);
  onSaleViewError(ErrorMessage err);
}
