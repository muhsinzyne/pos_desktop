import 'package:get/get.dart';

import '../modules/add-product-offline/bindings/add_product_offline_binding.dart';
import '../modules/add-product-offline/views/add_product_offline_view.dart';
import '../modules/add_expense/bindings/add_expense_binding.dart';
import '../modules/add_expense/views/add_expense_view.dart';
import '../modules/auth/licence/bindings/licence_screen_binding.dart';
import '../modules/auth/licence/views/licence_screen.dart';
import '../modules/auth/login/bindings/login_screen_binding.dart';
import '../modules/auth/login/views/login_screen.dart';
import '../modules/auth/open-register/bindings/open_register_binding.dart';
import '../modules/auth/open-register/views/open_register_view.dart';
import '../modules/auth/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/auth/otp_verification/views/otp_verification_view.dart';
import '../modules/close_register/bindings/close_register_binding.dart';
import '../modules/close_register/views/close_register_view.dart';
import '../modules/connect_printer/bindings/connect_printer_binding.dart';
import '../modules/connect_printer/views/connect_printer_view.dart';
import '../modules/crud/customer/customer-add/bindings/customer_add_binding.dart';
import '../modules/crud/customer/customer-add/views/customer_add_view.dart';
import '../modules/crud/customer/customer-edit/bindings/customer_edit_binding.dart';
import '../modules/crud/customer/customer-edit/views/customer_edit_view.dart';
import '../modules/crud/customer/customer-list/bindings/customer_list_binding.dart';
import '../modules/crud/customer/customer-list/views/customer_list_view.dart';
import '../modules/crud/customer/customer-view/bindings/customer_view_binding.dart';
import '../modules/crud/customer/customer-view/views/customer_view_view.dart';
import '../modules/dashboard/bindings/dashboard_screen_binding.dart';
import '../modules/dashboard/views/dashboard_screen.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/my-account/bindings/my_account_binding.dart';
import '../modules/my-account/views/my_account_view.dart';
import '../modules/payment/customer-payment/bindings/customer_payment_binding.dart';
import '../modules/payment/customer-payment/views/customer_payment_view.dart';
import '../modules/payment/sale-payment/bindings/sale_payment_binding.dart';
import '../modules/payment/sale-payment/views/sale_payment_view.dart';
import '../modules/pos-delivery/add-expenses/bindings/delivery_add_expenses_binding.dart';
import '../modules/pos-delivery/add-expenses/views/delivery_add_expenses_screen.dart';
import '../modules/pos-delivery/add-orders/bindings/delivery_orders_binding.dart';
import '../modules/pos-delivery/add-orders/views/delivery_orders_screen.dart';
import '../modules/pos-delivery/add-products-order/bindings/delivery_add_products_order_binding.dart';
import '../modules/pos-delivery/add-products-order/views/delivery_add_products_order_screen.dart';
import '../modules/pos-delivery/add-products-sales/bindings/delivery_add_products_sales_binding.dart';
import '../modules/pos-delivery/add-products-sales/views/delivery_add_products_sales_screen.dart';
import '../modules/pos-delivery/add-sales/bindings/delivery_sales_binding.dart';
import '../modules/pos-delivery/add-sales/views/delivery_sales_screen.dart';
import '../modules/pos-delivery/add-store-manually/bindings/delivery_add_store_manually_binding.dart';
import '../modules/pos-delivery/add-store-manually/views/delivery_add_store_manually_screen.dart';
import '../modules/pos-delivery/amount-transfer/bindings/delivery_amount_transfer_binding.dart';
import '../modules/pos-delivery/amount-transfer/views/delivery_amount_transfer_screen.dart';
import '../modules/pos-delivery/cash-register/bindings/delivery_cash_register_binding.dart';
import '../modules/pos-delivery/cash-register/views/delivery_cash_register_screen.dart';
import '../modules/pos-delivery/close-register/bindings/delivery_close_register_binding.dart';
import '../modules/pos-delivery/close-register/views/delivery_close_register_screen.dart';
import '../modules/pos-delivery/expenses/bindings/delivery_expenses_binding.dart';
import '../modules/pos-delivery/expenses/views/delivery_expenses_screen.dart';
import '../modules/pos-delivery/home/bindings/delivery_home_binding.dart';
import '../modules/pos-delivery/home/views/delivery_home_screen.dart';
import '../modules/pos-delivery/new-design/add-store/bindings/new_add_store_binding.dart';
import '../modules/pos-delivery/new-design/add-store/views/new_add_store_screen.dart';
import '../modules/pos-delivery/new-design/basket/bindings/new_basket_binding.dart';
import '../modules/pos-delivery/new-design/basket/views/new_basket_screen.dart';
import '../modules/pos-delivery/new-design/complete-sale/bindings/new_complete_sale_binding.dart';
import '../modules/pos-delivery/new-design/complete-sale/views/new_complete_sale_screen.dart';
import '../modules/pos-delivery/new-design/completed-payments/bindings/new_completed_payments_binding.dart';
import '../modules/pos-delivery/new-design/completed-payments/views/new_completed_payments_screen.dart';
import '../modules/pos-delivery/new-design/dashboard/bindings/new_dashboard_binding.dart';
import '../modules/pos-delivery/new-design/dashboard/views/new_dashboard_screen.dart';
import '../modules/pos-delivery/new-design/financial/bindings/new_financial_binding.dart';
import '../modules/pos-delivery/new-design/financial/views/new_financial_screen.dart';
import '../modules/pos-delivery/new-design/lock/bindings/new_lock_binding.dart';
import '../modules/pos-delivery/new-design/lock/views/new_lock_screen.dart';
import '../modules/pos-delivery/new-design/payment-history/bindings/new_pending_payments_binding.dart';
import '../modules/pos-delivery/new-design/payment-history/views/new_payment_history_screen.dart';
import '../modules/pos-delivery/new-design/pending-payments/bindings/new_pending_payments_binding.dart';
import '../modules/pos-delivery/new-design/pending-payments/views/new_pending_payments_screen.dart';
import '../modules/pos-delivery/new-design/print-invoice/bindings/new_print_invoice_binding.dart';
import '../modules/pos-delivery/new-design/print-invoice/views/new_print_invoice_screen.dart';
import '../modules/pos-delivery/new-design/qr-scanning/bindings/new_add_store_binding.dart';
import '../modules/pos-delivery/new-design/qr-scanning/views/new_qr_screen.dart';
import '../modules/pos-delivery/new-design/quotations/bindings/new_quotations_binding.dart';
import '../modules/pos-delivery/new-design/quotations/views/new_quotations_screen.dart';
import '../modules/pos-delivery/new-design/sales-list/bindings/new_sales_list_binding.dart';
import '../modules/pos-delivery/new-design/sales-list/views/new_sales_list_screen.dart';
import '../modules/pos-delivery/new-design/sales/bindings/new_sales_binding.dart';
import '../modules/pos-delivery/new-design/sales/views/new_sales_screen.dart';
import '../modules/pos-delivery/new-design/store/bindings/new_store_binding.dart';
import '../modules/pos-delivery/new-design/store/views/new_store_screen.dart';
import '../modules/pos-delivery/open-register/bindings/delivery_open_register_binding.dart';
import '../modules/pos-delivery/open-register/views/delivery_open_register_screen.dart';
import '../modules/pos-delivery/order-invoice/bindings/delivery_order_invoice_binding.dart';
import '../modules/pos-delivery/order-invoice/views/delivery_order_invoice_screen.dart';
import '../modules/pos-delivery/order-payment/bindings/delivery_order_payment_binding.dart';
import '../modules/pos-delivery/order-payment/views/delivery_order_payment_screen.dart';
import '../modules/pos-delivery/payment-due/bindings/delivery_payment_due_binding.dart';
import '../modules/pos-delivery/payment-due/views/delivery_payment_due_screen.dart';
import '../modules/pos-delivery/payment-history/bindings/delivery_payment_history_binding.dart';
import '../modules/pos-delivery/payment-history/views/delivery_payment_history_screen.dart';
import '../modules/pos-delivery/payment-home/bindings/delivery_payment_home_binding.dart';
import '../modules/pos-delivery/payment-home/views/delivery_payment_home_screen.dart';
import '../modules/pos-delivery/payment-invoice/bindings/delivery_payment_invoice_binding.dart';
import '../modules/pos-delivery/payment-invoice/views/delivery_payment_invoice_screen.dart';
import '../modules/pos-delivery/pending-payments/bindings/delivery_pending_payments_binding.dart';
import '../modules/pos-delivery/pending-payments/views/delivery_pending_payments_screen.dart';
import '../modules/pos-delivery/products-for-orders/bindings/delivery_products_for_orders_binding.dart';
import '../modules/pos-delivery/products-for-orders/views/delivery_products_for_orders_screen.dart';
import '../modules/pos-delivery/products-for-sales/bindings/delivery_products_for_sales_binding.dart';
import '../modules/pos-delivery/products-for-sales/views/delivery_products_for_sales_screen.dart';
import '../modules/pos-delivery/register-history/bindings/delivery_register_history_binding.dart';
import '../modules/pos-delivery/register-history/views/delivery_register_history_screen.dart';
import '../modules/pos-delivery/sale-invoice/bindings/delivery_sale_invoice_binding.dart';
import '../modules/pos-delivery/sale-invoice/views/delivery_sale_invoice_screen.dart';
import '../modules/pos-delivery/sales-payment/bindings/delivery_sales_payment_binding.dart';
import '../modules/pos-delivery/sales-payment/views/delivery_sales_payment_screen.dart';
import '../modules/pos-delivery/select-store/bindings/delivery_select_store_binding.dart';
import '../modules/pos-delivery/select-store/views/delivery_select_store_screen.dart';
import '../modules/pos-delivery/splash/bindings/delivery_splash_binding.dart';
import '../modules/pos-delivery/splash/views/delvery_splash_screen.dart';
import '../modules/pos-delivery/store-details/bindings/delivery_store_details_binding.dart';
import '../modules/pos-delivery/store-details/views/delivery_store_details_screen.dart';
import '../modules/pos/add-product/bindings/add_product_binding.dart';
import '../modules/pos/add-product/views/add_product_view.dart';
import '../modules/pos/edit-product/bindings/edit_product_binding.dart';
import '../modules/pos/edit-product/views/edit_product_view.dart';
import '../modules/pos/find-customer/bindings/find_customer_screen_binding.dart';
import '../modules/pos/find-customer/views/find_customer_screen.dart';
import '../modules/pos/pos-payment/bindings/pos_payment_binding.dart';
import '../modules/pos/pos-payment/views/pos_payment_view.dart';
import '../modules/pos/pos_bill/bindings/pos_bill_screen_binding.dart';
import '../modules/pos/pos_bill/views/pos_bill_screen.dart';
import '../modules/pos/print-view/bindings/print_screen_binding.dart';
import '../modules/pos/print-view/views/print_screen.dart';
import '../modules/pos/sales-list/bindings/sales_list_screen_binding.dart';
import '../modules/pos/sales-list/views/sales_list_screen.dart';
import '../modules/product_list/bindings/product_list_binding.dart';
import '../modules/product_list/views/product_list_view.dart';
import '../modules/register_details/bindings/register_details_binding.dart';
import '../modules/register_details/views/register_details_view.dart';
import '../modules/sales_point/bindings/sales_point_binding.dart';
import '../modules/sales_point/views/sales_point_view.dart';
import '../modules/settings/change-language/bindings/change_language_binding.dart';
import '../modules/settings/change-language/views/change_language_view.dart';
import '../modules/splash/bindings/splash_screen_binding.dart';
import '../modules/splash/views/splash_screen.dart';
import '../modules/test/bindings/test_binding.dart';
import '../modules/test/views/test_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;
  static const deliveryInitial = Routes.deliverySplash;

  static final routes = [
    //new design
    GetPage(
      name: _Paths.newLock,
      page: () => NewLockScreen(),
      binding: NewLockScreenBinding(),
    ),
    GetPage(
      name: _Paths.newQr,
      page: () => NewQRScreen(),
      binding: NewQRScreenBinding(),
    ),
    GetPage(
      name: _Paths.newPaymentHistory,
      page: () => NewPaymentHistoryScreen(),
      binding: NewPaymentHistoryScreenBinding(),
    ),
    GetPage(
      name: _Paths.newFinancial,
      page: () => NewFinancialScreen(),
      binding: NewFinancialScreenBinding(),
    ),
    GetPage(
      name: _Paths.newCompletedPayments,
      page: () => NewCompletedPaymentsScreen(),
      binding: NewCompletedPaymentsScreenBinding(),
    ),
    GetPage(
      name: _Paths.newPendingPayments,
      page: () => NewPendingPaymentsScreen(),
      binding: NewPendingPaymentsScreenBinding(),
    ),
    GetPage(
      name: _Paths.newQuotations,
      page: () => NewQuotationsScreen(),
      binding: NewQuotationsScreenBinding(),
    ),
    GetPage(
      name: _Paths.newSalesList,
      page: () => NewSalesListScreen(),
      binding: NewSalesListScreenBinding(),
    ),
    GetPage(
      name: _Paths.newCompleteSale,
      page: () => NewCompleteSaleScreen(),
      binding: NewCompleteSaleScreenBinding(),
    ),
    GetPage(
      name: _Paths.newBasket,
      page: () => NewBasketScreen(),
      binding: NewBasketScreenBinding(),
    ),
    GetPage(
      name: _Paths.newStore,
      page: () => NewStoreScreen(),
      binding: NewStoreScreenBinding(),
    ),
    GetPage(
      name: _Paths.newSales,
      page: () => NewSalesScreen(),
      binding: NewSalesScreenBinding(),
    ),
    GetPage(
      name: _Paths.newAddStore,
      page: () => NewAddStoreScreen(),
      binding: NewAddStoreScreenBinding(),
    ),
    GetPage(
      name: _Paths.newDashboard,
      page: () => NewDashboardScreen(),
      binding: NewDashboardScreenBinding(),
    ),
    GetPage(
      name: _Paths.newPrintInvoice,
      page: () => NewPrintInvoiceScreen(),
      binding: NewPrintInvoiceScreenBinding(),
    ),

    //pos-delivrey routes
    GetPage(
      name: _Paths.deliverySplash,
      page: () => DeliverySplashScreen(),
      binding: DeliverySplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryHome,
      page: () => DeliveryHomeScreen(),
      binding: DeliveryHomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryAddStore,
      page: () => DeliveryAddStoreManuallyScreen(),
      binding: DeliveryAddStoreManuallyScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliverySelectStore,
      page: () => DeliveryAddStoreScreen(),
      binding: DeliverySelectStoreScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryStoreDetails,
      page: () => const DeliveryStoreDetailsScreen(),
      binding: DeliveryStoreDetailsScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliverySalesPayment,
      page: () => const DeliverySalesPaymentScreen(),
      binding: DeliverySalesPaymentScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliverySales,
      page: () => const DeliverySalesScreen(),
      binding: DeliverySalesScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryAddProductsSales,
      page: () => const DeliveryAddProductsSalesScreen(),
      binding: DeliveryAddProductsSalesScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliverySaleInvoice,
      page: () => const DeliverySaleInvoiceScreen(),
      binding: DeliverySaleInvoiceScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryPaymentHome,
      page: () => const DeliveryPaymentHomeScreen(),
      binding: DeliveryPaymentHomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryPaymentDue,
      page: () => const DeliveryPaymentDueScreen(),
      binding: DeliveryPaymentDueScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryPaymentInvoice,
      page: () => const DeliveryPaymentInvoiceScreen(),
      binding: DeliveryPaymentInvoiceScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryPaymentHistory,
      page: () => DeliveryPaymentHistoryScreen(),
      binding: DeliveryPaymentHistoryScreenBinding(),
    ),
    GetPage(
      name: _Paths.deliveryRegisterHistory,
      page: () => DeliveryRegisterHistoryScreen(),
      binding: DeliveryRegisterHistoryScreenBinding(),
    ),
    GetPage(
        name: _Paths.deliveryCashRegister,
        page: () => const DeliveryCashRegisterScreen(),
        binding: DeliveryCashRegisterScreenBinding()),
    GetPage(
        name: _Paths.deliveryOpenRegister,
        page: () => DeliveryOpenRegisterScreen(),
        binding: DeliveryOpenRegisterScreenBinding()),
    GetPage(
        name: _Paths.deliveryCloseRegister,
        page: () => DeliveryCloseRegisterScreen(),
        binding: DeliveryCloseRegisterScreenBinding()),
    GetPage(
        name: _Paths.deliveryAmountTransfer,
        page: () => DeliveryAmountTransferScreen(),
        binding: DeliveryAmountTransferScreenBinding()),
    GetPage(
        name: _Paths.deliveryPendingPayment,
        page: () => DeliveryPendingPaymentScreen(),
        binding: DeliveryPendingPaymentScreenBinding()),
    GetPage(
        name: _Paths.deliveryOrderPayment,
        page: () => const DeliveryOrderPaymentScreen(),
        binding: DeliveryOrderPaymentScreenBinding()),
    GetPage(
        name: _Paths.deliveryOrderInvoice,
        page: () => const DeliveryOrderInvoiceScreen(),
        binding: DeliveryOrderInvoiceScreenBinding()),
    GetPage(
        name: _Paths.deliveryProductsForSales,
        page: () => DeliveryProductsForSalesScreen(),
        binding: DeliveryProductsForSalesScreenBinding()),
    GetPage(
        name: _Paths.deliveryProductsForOrders,
        page: () => DeliveryProductsForOrdersScreen(),
        binding: DeliveryProductsForOrdersScreenBinding()),
    GetPage(
        name: _Paths.deliveryOrders,
        page: () => const DeliveryOrdersScreen(),
        binding: DeliveryOrdersScreenBinding()),
    GetPage(
        name: _Paths.deliveryAddExpenses,
        page: () => DeliveryAddExpensesScreen(),
        binding: DeliveryAddExpensesScreenBinding()),
    GetPage(
        name: _Paths.deliveryExpenses,
        page: () => DeliveryExpensesScreen(),
        binding: DeliveryExpensesScreenBinding()),
    GetPage(
      name: _Paths.deliveryAddProductsOrder,
      page: () => const DeliveryAddProductsOrderScreen(),
      binding: DeliveryAddProductsOrderScreenBinding(),
    ),

    //pos-desktop
    GetPage(
      name: _Paths.connectPrinter,
      page: () => ConnectPrinterView(),
      binding: ConnectPrinterBinding(),
    ),
    GetPage(
      name: _Paths.addProductOffline,
      page: () => AddProductOfflineView(),
      binding: AddProductOfflineBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardScreenBinding(),
    ),
    GetPage(
      name: _Paths.otpVerification,
      page: () => OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.changeLanguage,
      page: () => ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: _Paths.myAccount,
      page: () => MyAccountView(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: _Paths.licence,
      page: () => LicenceScreen(),
      binding: LicenceBinding(),
    ),
    GetPage(
      name: _Paths.findCustomer,
      page: () => FindCustomerScreen(),
      binding: FindCustomerScreenBinding(),
    ),
    GetPage(
      name: _Paths.printView,
      page: () => PrintScreen(),
      binding: PrintScreenBinding(),
    ),
    GetPage(
      name: _Paths.salesList,
      page: () => SalesListScreen(),
      binding: SalesListScreenBinding(),
    ),
    GetPage(
      name: _Paths.posBill,
      page: () => PosBillView(),
      binding: PosBillScreenBinding(),
    ),
    GetPage(
      name: _Paths.addProduct,
      page: () => AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.posPayment,
      page: () => PosPaymentView(),
      binding: PosPaymentBinding(),
    ),
    GetPage(
      name: _Paths.editProduct,
      page: () => EditProductView(),
      binding: EditProductBinding(),
    ),
    GetPage(
      name: _Paths.test,
      page: () => TestView(),
      binding: TestBinding(),
    ),
    GetPage(
      name: _Paths.customerPayment,
      page: () => CustomerPaymentView(),
      binding: CustomerPaymentBinding(),
    ),
    GetPage(
      name: _Paths.customerList,
      page: () => CustomerListView(),
      binding: CustomerListBinding(),
    ),
    GetPage(
      name: _Paths.customerView,
      page: () => CustomerViewView(),
      binding: CustomerViewBinding(),
    ),
    GetPage(
      name: _Paths.customerAdd,
      page: () => CustomerAddView(),
      binding: CustomerAddBinding(),
    ),
    GetPage(
      name: _Paths.customerEdit,
      page: () => CustomerEditView(),
      binding: CustomerEditBinding(),
    ),
    GetPage(
      name: _Paths.salePayment,
      page: () => SalePaymentView(),
      binding: SalePaymentBinding(),
    ),
    GetPage(
      name: _Paths.openRegister,
      page: () => OpenRegisterView(),
      binding: OpenRegisterBinding(),
    ),
    GetPage(
      name: _Paths.homePos,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SALES_POINT,
      page: () => SalesPointView(),
      binding: SalesPointBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_DETAILS,
      page: () => RegisterDetailsView(),
      binding: RegisterDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPENSE,
      page: () => AddExpenseView(),
      binding: AddExpenseBinding(),
    ),
    GetPage(
      name: _Paths.CLOSE_REGISTER,
      page: () => CloseRegisterView(),
      binding: CloseRegisterBinding(),
    ),
  ];
}
