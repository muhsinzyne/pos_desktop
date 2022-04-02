// To parse this JSON data, do
//
//     final warehouseProductsResponse = warehouseProductsResponseFromJson(jsonString);

import 'dart:convert';

List<WarehouseProductsResponse> warehouseProductsResponseFromJson(String str) =>
    List<WarehouseProductsResponse>.from(
        json.decode(str).map((x) => WarehouseProductsResponse.fromJson(x)));

String warehouseProductsResponseToJson(List<WarehouseProductsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WarehouseProductsResponse {
  WarehouseProductsResponse({
    this.id,
    this.productId,
    this.warehouseId,
    this.quantity,
    this.rack,
    this.avgCost,
  });

  String? id;
  String? productId;
  String? warehouseId;
  String? quantity;
  dynamic rack;
  String? avgCost;

  factory WarehouseProductsResponse.fromJson(Map<String, dynamic> json) =>
      WarehouseProductsResponse(
        id: json["id"],
        productId: json["product_id"],
        warehouseId: json["warehouse_id"],
        quantity: json["quantity"],
        rack: json["rack"],
        avgCost: json["avg_cost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "warehouse_id": warehouseId,
        "quantity": quantity,
        "rack": rack,
        "avg_cost": avgCost,
      };
}
