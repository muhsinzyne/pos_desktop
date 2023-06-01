import 'dart:ui';
import 'package:posdelivery/models/currency_format.dart';

class Constants {
  static const unDefinedIndex = -1;
  static const isTaxProduct = '1';
  static const nonTaxProduct = '0';
  static const forwardSlash = '/';
  static const taxTypePercentage = '1';
  static const taxTypeFlat = '2';
  static const taxInclusive = '0';
  static const taxExclusive = '1';
  static const no1 = '1';
  static const none = '';
  static const stringNull = 'null';
  static const ios = 'ios';
  static const android = 'android';
  static const macOs = 'mac_os';
  static const windows = 'windows';
  static const linux = 'linux';
  static const isLastLoggedIn = 'is_last_logged_in';
  static const cCustomer = 'current_customer';
  static const cBiller = 'current_biller';
  static const cWareHouse = 'current_warehouse';
  static const authToken = 'auth_token';
  static const appServer = 'app_server';
  static const appPrefix = 'app_prefix';
  static const smaUploadPath = '/assets/uploads';
  static const avatarLocation = 'avatars/';
  static const pagePadding = 20.0;
  static const pagePadding15 = 15.0;
  static const pagePadding10 = 10.0;
  static const pagePadding5 = 5.0;
  static const defaultAppVersionD = '0.0.1';
  static const defaultAppBuildNo = '1';
  static const version = 'Version';
  static const apiConnectionTimeOut = 12000;
  static const apiReceiveTimeOut = 12000;
  static const authorization = 'Authorization';
  static const bearer = 'Bearer';
  static const commonSafeAreaTop = 120;
  static const otpLength = 4;
  static const retryRequestCount = 3;
  static const dinNextLTArabic = 'DIN Next LT Arabic';
  static const roboto = 'Roboto';
  static const dataImageTypeBase64 = 'data:image/jpg;base64,';
  static const defaultMonthFormat = 'MMMM, y';
  static const defaultDateTimeFormat = 'y-M-d h:mm a';
  static const appLogoInvertPath = 'assets/images/fatoorah-invert.png';
  static const appLogoPath = 'assets/images/fatoorah.png';
  static const logoHeroTag = 'logo-hero-tag';
  static const licenceCodeLength = 10;
  static const stringExpressionStart = '[';
  static const stringExpressionStop = ']';
  static const uploadsPath = '/assets/uploads/';
  static const logosPath = '/logos/';
  static const invoicePdfPrefix = '/admin/sales/api_pdf/';
  static const pdf = '.pdf';
  static const paidByCash = 'cash';
  static const paidByDeposit = 'deposit';
  static const Duration smallDuration = Duration(milliseconds: 300);
  static const Duration oneSecDuration = Duration(seconds: 1);
  static const Duration fourSec = Duration(seconds: 4);
  static const databaseFileName = 'pos_desktop.json';
  static const desktopAddSale = "desktop_add_sale";
  //stores
  static const productsStore = 'products_list';
  static const warehouseListStore = "warehouse_list";
  static const customerListStore = "customer_list";
  static const customerGroupeStore = "customer_group_list";
  static const warehouseProductsStore = "warehouse_products_list";
  static const productsOfflineStore = "products_offline_list";
  static const expensesStore = 'expenses_list';

  //pos-delivery
  static const deliveryDatabaseFileName = 'pos_delivery.db';
  static const deliveryAddStoreForm = 'add_store_form';
  static const deliveryAddSaleForm = 'add_sale_form';
  static const deliveryAddExpenseForm = 'add_expense_form';
  static const deliveryAddOrderForm = 'add_order_form';
  static const deliveryProductsSales = 'delivery_products_sales';
  static const deliveryCartProducts = 'delivery_cart_products';

  static double screenHeight =
      window.physicalSize.height / window.devicePixelRatio;
  static double screenWidth =
      window.physicalSize.width / window.devicePixelRatio;
  static double screenHeightSafearea = screenHeight -
      ((window.padding.top / window.devicePixelRatio) +
          (window.padding.bottom / window.devicePixelRatio));
//status bar height
  // static double statusBarHeight = window.padding.top / window.devicePixelRatio;
}

class CurrencyConst {
  static CurrencyFormat srFormat1 =
      CurrencyFormat(format: "##,##,##0", symbol: 'SR', decimal: '0#');
  static CurrencyFormat srFormat2 =
      CurrencyFormat(format: "##,##,##0", symbol: 'SR', decimal: '##');
}

class SalesStatus {
  static const returned = 'returned';
  static const completed = 'completed';
}
