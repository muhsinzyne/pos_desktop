import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/delivery/requests/expense_add_request.dart';
import 'package:posdelivery/models/requests/pos/sale_offline_request.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/response/customer/customer_data.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/product_offline.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/services/base/get_x_service.dart';
// import 'package:posdelivery/services/file/file_storage_service.dart';
import 'package:posdelivery/services/storage/sembast_storage_service.dart';
import 'package:sembast/sembast.dart';

class CacheSembastService extends BaseGetXService {
  @override
  Future dependencies() async {}

  SembastStorage localStorage = Get.find<SembastStorage>();
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  Future<bool> deleteAddExpenseFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddExpenseForm);
    Database? db = await localStorage.db;
    try {
      await db?.transaction((transaction) async {
        await store.drop(transaction);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ExpenseAddRequest>> getAddExpenseFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddExpenseForm);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<ExpenseAddRequest> result = [];
    for (var record in records) {
      result.add(
          ExpenseAddRequest.fromJson(record.value as Map<String, dynamic>));
    }
    return result;
  }

  setAddExpenseFormData(ExpenseAddRequest item) async {
    StoreRef store = localStorage.getMapStore(Constants.expensesStore);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          // await store.record(key).put(transaction, item.toJson())
          await store.add(transaction, item.toJson())
        });
    return item;
  }

  Future<List<ProductOffline>> getAllProductsOffline() async {
    StoreRef store = localStorage.getMapStore(Constants.productsOfflineStore);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<ProductOffline> result = [];
    for (var record in records) {
      result.add(ProductOffline.fromJson(record.value as Map<String, dynamic>));
    }
    return result;
  }

  setProductsOfflineData(ProductOffline item) async {
    // int key = int.parse(item.code!);
    StoreRef store = localStorage.getMapStore(Constants.productsOfflineStore);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          // await store.record(key).put(transaction, item.toJson())
          await store.add(transaction, item.toJson())
        });
    return item;
  }

  setWarehouseProductData(
      String storeName, WarehouseProductsResponse item) async {
    int key = int.parse(item.id.toString());
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          await store.record(key).put(transaction, item.toJson())
          //await store.add(transaction, item.toJson())
        });
    return item;
  }

  Future getWarehouseProductData(String storeName, int key) async {
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    var record = await store.record(key).get(db!);
    if (record != null) {
      return record;
    } else {
      return null;
    }
  }

  Future<List<WarehouseProductsResponse>> getAllWarehouseProducts(
      String storeName) async {
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<WarehouseProductsResponse> result = [];
    for (var record in records) {
      result.add(WarehouseProductsResponse.fromJson(
          record.value as Map<String, dynamic>));
    }
    return result;
  }

  setWarehouseData(WarehouseListResponse warehouse) async {
    int key = int.parse(warehouse.id.toString());
    StoreRef store = localStorage.getMapStore(Constants.warehouseListStore);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          await store.record(key).put(transaction, warehouse.toJson())
          //await store.add(transaction, item.toJson())
        });
    return warehouse;
  }

  Future getWarehouseData(int key) async {
    StoreRef store = localStorage.getMapStore(Constants.warehouseListStore);
    Database? db = await localStorage.db;
    var record = await store.record(key).get(db!);
    if (record != null) {
      return record;
    } else {
      return null;
    }
  }

  Future<List<WarehouseListResponse>> getAllwarehouses() async {
    StoreRef store = localStorage.getMapStore(Constants.warehouseListStore);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<WarehouseListResponse> result = [];
    for (var record in records) {
      result.add(
          WarehouseListResponse.fromJson(record.value as Map<String, dynamic>));
    }
    return result;
  }

  setCustomerData(CustomerListOffResponse customer) async {
    int key = int.parse(customer.id.toString());
    StoreRef store = localStorage.getMapStore(Constants.customerListStore);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          await store.record(key).put(transaction, customer.toJson())
          //await store.add(transaction, item.toJson())
        });
    return customer;
  }

  Future<CustomerListOffResponse> getCustomerData(int key) async {
    StoreRef store = localStorage.getMapStore(Constants.customerListStore);
    Database? db = await localStorage.db;
    var record = await store.record(key).get(db!);
    CustomerListOffResponse data;
    logger.e(record);
    //CustomerListOffResponse();
    data = CustomerListOffResponse.fromJson(record as Map<String, dynamic>);
    return data;
  }

  Future<List<CustomerListOffResponse>> getAllCustomers() async {
    StoreRef store = localStorage.getMapStore(Constants.customerListStore);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<CustomerListOffResponse> result = [];
    for (var record in records) {
      result.add(CustomerListOffResponse.fromJson(
          record.value as Map<String, dynamic>));
    }
    return result;
  }

  setProductData(String storeName, Product item) async {
    int key = int.parse(item.itemId.toString());
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          await store.record(key).put(transaction, item.toJson())
          //await store.add(transaction, item.toJson())
        });
    return item;
  }

  Future getProductData(String storeName, int key) async {
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    var record = await store.record(key).get(db!);
    if (record != null) {
      return record;
    } else {
      return null;
    }
  }

  Future<List<Product>> getAllProducts() async {
    StoreRef store = localStorage.getMapStore(Constants.productsStore);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<Product> result = [];
    for (var record in records) {
      result.add(Product.fromJson(record.value as Map<String, dynamic>));
    }
    return result;
  }

  Future<bool> deleteData(String storeName, int? id) async {
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    try {
      await db?.transaction((transaction) async {
        await store.record(id).delete(transaction);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  setAddSaleData(SaleOfflineRequest saleOfflineRequest) async {
    StoreRef store = localStorage.getMapStore(Constants.desktopAddSale);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async =>
        {await store.add(transaction, saleOfflineRequest.toJson())});
    return saleOfflineRequest;
  }

  Future<List<SaleRequest>> getAddSaleData() async {
    StoreRef store = localStorage.getMapStore(Constants.desktopAddSale);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<SaleRequest> result = [];
    for (var record in records) {
      result.add(SaleRequest.fromJson(record.value as Map<String, dynamic>));
    }
    return result;
  }

  Future<bool> deleteAddSaleFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.desktopAddSale);
    Database? db = await localStorage.db;
    try {
      await db?.transaction((transaction) async {
        await store.drop(transaction);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
