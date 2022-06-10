import 'dart:convert';

import 'package:get/get.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/customer/customer_data.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/desktop/warehouse_list.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/services/base/get_x_service.dart';
// import 'package:posdelivery/services/file/file_storage_service.dart';
import 'package:posdelivery/services/storage/sembast_storage_service.dart';
import 'package:sembast/sembast.dart';

class CacheSembastService extends BaseGetXService {
  @override
  Future dependencies() async {}

  SembastStorage localStorage = Get.find<SembastStorage>();

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

  Future<List<dynamic>> getAllwarehouses() async {
    StoreRef store = localStorage.getMapStore(Constants.warehouseListStore);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<dynamic> result = [];
    for (var record in records) {
      result.add(record);
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

  Future getCustomerData(String storeName, int key) async {
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    var record = await store.record(key).get(db!);
    if (record != null) {
      return record;
    } else {
      return null;
    }
  }

  Future<List<dynamic>> getAllCustomers() async {
    StoreRef store = localStorage.getMapStore(Constants.customerListStore);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<dynamic> result = [];
    for (var record in records) {
      result.add(record);
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

  Future<List<dynamic>> getAllProducts(String storeName) async {
    StoreRef store = localStorage.getMapStore(storeName);
    Database? db = await localStorage.db;
    var records = await store.find(
      db!,
      finder: Finder(
        sortOrders: [SortOrder('order')],
      ),
    );
    List<dynamic> result = [];
    for (var record in records) {
      result.add(record);
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
