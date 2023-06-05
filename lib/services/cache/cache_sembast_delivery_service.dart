import 'dart:convert';

import 'package:dio/dio.dart' as form;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/delivery/requests/cart_product.dart';
import 'package:posdelivery/models/delivery/requests/expense_add_request.dart';
import 'package:posdelivery/models/delivery/requests/order_add_request.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/requests/pos/sale_request.dart';
import 'package:posdelivery/models/response/customer/customer_data.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_products.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/services/base/get_x_service.dart';
import 'package:posdelivery/services/storage/sembast_delivery_storage_service.dart';
// import 'package:posdelivery/services/file/file_storage_service.dart';
import 'package:posdelivery/services/storage/sembast_storage_service.dart';
import 'package:sembast/sembast.dart';

class CacheSembastDeliveryService extends BaseGetXService {
  @override
  Future dependencies() async {}
  SembastDeliveryStorage localStorage = Get.find<SembastDeliveryStorage>();
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

//delivery

  Future<bool> deleteAddSaleFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddSaleForm);
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

  Future<List<SaleRequest>> getAllAddSaleFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddSaleForm);
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

  setAddSaleFormData(SaleRequest item) async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddSaleForm);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          // await store.record(key).put(transaction, item.toJson())
          await store.add(transaction, item.toJson())
        });
    return item;
  }

  Future<bool> deleteAllCartProductsData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryCartProducts);
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

  Future<bool> deleteCartProductData(int id) async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryCartProducts);
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

  Future<CartProduct> getCartProductForSaleData(int key) async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryCartProducts);
    Database? db = await localStorage.db;
    var record = await store.record(key).get(db!);
    return CartProduct.fromJson(record as Map<String, dynamic>);
  }

  Future getCartProductData(String key) async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryCartProducts);
    Database? db = await localStorage.db;
    var finder = Finder(filter: Filter.equals('itemId', key));
    var record = await store.findFirst(db!, finder: finder);
    logger.wtf(record);
    // var record = await store.record(key).get(db!);
    if (record != null) {
      return CartProduct.fromJson(record.value as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future updateCartProductData(CartProduct item) async {
    // int key = int.parse(item.itemId.toString());
    StoreRef store = localStorage.getMapStore(Constants.deliveryCartProducts);
    Database? db = await localStorage.db;
    var finder = Finder(filter: Filter.equals('itemId', item.itemId));
    var record = await store.findFirst(db!, finder: finder);
    if (record != null) {
      await db.transaction((transaction) async =>
          {await store.record(record.key).put(transaction, item.toJson())});
    } else {
      return null;
    }
  }

  Future<List<CartProduct>> getAllCartProducts() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryCartProducts);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<CartProduct> result = [];
    for (var record in records) {
      result.add(CartProduct.fromJson(record.value as Map<String, dynamic>));
      // result.add(jsonEncode(record.value));
      // result.add(CartProduct.fromJson(record.value));
    }
    return result;
  }

  setCartProductsData(CartProduct item) async {
    // int key = int.parse(item.itemId.toString());
    StoreRef store = localStorage.getMapStore(Constants.deliveryCartProducts);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async {
      // await store.record(key).put(transaction, item.toJson())
      var id = await store.add(transaction, item.toJson());
      item.key = id as int;
      await store.record(id).put(transaction, item.toJson());
    });
    return item;
  }

  setAddOrderFormData(OrderAddRequest item) async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddOrderForm);
    Database? db = await localStorage.db;
    await db!.transaction(
        (transaction) async => {await store.add(transaction, item.toJson())});
    return item;
  }

  Future<List<OrderAddRequest>> getAddFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddOrderForm);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<OrderAddRequest> result = [];
    for (var record in records) {
      result
          .add(OrderAddRequest.fromJson(record.value as Map<String, dynamic>));
    }
    return result;
  }

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
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddExpenseForm);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          // await store.record(key).put(transaction, item.toJson())
          await store.add(transaction, item.toJson())
        });
    return item;
  }

  setAddstoreFormData(StoreAddRequest item) async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddStoreForm);
    Database? db = await localStorage.db;
    await db!.transaction((transaction) async => {
          // await store.record(key).put(transaction, item.toJson())
          await store.add(transaction, item.toJson())
        });
    return item;
  }

  Future<List<StoreAddRequest>> getAddstoreFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddStoreForm);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<StoreAddRequest> result = [];
    for (var record in records) {
      result
          .add(StoreAddRequest.fromJson(record.value as Map<String, dynamic>));
    }
    return result;
  }

  Future<bool> deleteAddStoreFormData() async {
    StoreRef store = localStorage.getMapStore(Constants.deliveryAddStoreForm);
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

//----------------------

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

  Future<Product> getProductData(String storeName, int key) async {
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    var record = await store.record(key).get(db!);
    // if (record != null) {
    return Product.fromJson(record as Map<String, dynamic>);
    // }
    // else {
    //   return null;
    // }
  }

  Future<List<Product>> getAllProducts(String storeName) async {
    StoreRef store = localStorage.getMapStore(storeName);
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
}
