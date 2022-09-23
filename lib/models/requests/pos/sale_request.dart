class SaleRequest {
  String? test;
  String? customer;
  String? warehouse;
  String? addItem;
  List<String> productId = [];
  List<String> productType = [];
  List<String> productCode = [];
  List<String> productName = [];
  List<String> productOption = []; // string bool
  List<String> productComment = []; //empty
  List<String> serial = [];
  List<String> productDiscount = [];
  List<String> productTax = [];
  List<String> netPrice = [];
  List<String> unitPrice = [];
  List<String> realUnitPrice = [];
  List<String> quantity = [];
  List<String> productUnit = [];
  List<String> productBaseQuantity = [];
  String? biller;
  String? posNote;
  String? staffNote;
  List<String> amount = [];
  List<String> balanceAmount = [];
  List<String> paidBy = [];
  List<String> ccNo = [];
  List<String> payingGiftCardNo = [];
  List<String> ccHolder = [];
  List<String> chequeNo = [];
  List<String> ccMonth = [];
  List<String> ccYear = [];
  List<String> ccType = [];
  List<String> ccCvv2 = [];
  List<String> paymentNote = [];
  String? orderTax;
  String? discount;
  String? shipping;
  String? rPaidBy;
  String? totalItems;
  SaleRequest();
  SaleRequest.fromJSON(Map<String, dynamic> json) {
    test = json["test"];
    customer = json["customer"];
    warehouse = json["warehouse"];
    addItem = json["add_item"];
    productId = List<String>.from(json["product_id"].map((x) => x));
    productType = List<String>.from(json["product_type"].map((x) => x));
    productCode = List<String>.from(json["product_code"].map((x) => x));
    productName = List<String>.from(json["product_name"].map((x) => x));
    productOption = List<String>.from(json["product_option"].map((x) => x));
    productComment = List<String>.from(json["product_comment"].map((x) => x));
    serial = List<String>.from(json["serial"].map((x) => x));
    productDiscount = List<String>.from(json["product_discount"].map((x) => x));
    productTax = List<String>.from(json["product_tax"].map((x) => x));
    netPrice = List<String>.from(json["net_price"].map((x) => x));
    unitPrice = List<String>.from(json["unit_price"].map((x) => x));
    realUnitPrice = List<String>.from(json["real_unit_price"].map((x) => x));
    quantity = List<String>.from(json["quantity"].map((x) => x));
    productUnit = List<String>.from(json["product_unit"].map((x) => x));
    productBaseQuantity =
        List<String>.from(json["product_base_quantity"].map((x) => x));
    biller = json["biller"];
    posNote = json["pos_note"];
    staffNote = json["staff_note"];
    amount = List<String>.from(json["amount"].map((x) => x));
    balanceAmount = List<String>.from(json["balance_amount"].map((x) => x));
    paidBy = List<String>.from(json["paid_by"].map((x) => x));
    ccNo = List<String>.from(json["cc_no"].map((x) => x));
    payingGiftCardNo =
        List<String>.from(json["paying_gift_card_no"].map((x) => x));
    ccHolder = List<String>.from(json["cc_holder"].map((x) => x));
    chequeNo = List<String>.from(json["cheque_no"].map((x) => x));
    ccMonth = List<String>.from(json["cc_month"].map((x) => x));
    ccYear = List<String>.from(json["cc_year"].map((x) => x));
    ccType = List<String>.from(json["cc_type"].map((x) => x));
    ccCvv2 = List<String>.from(json["cc_cvv2"].map((x) => x));
    paymentNote = List<String>.from(json["payment_note"].map((x) => x));
    orderTax = json["order_tax"];
    discount = json["discount"];
    shipping = json["shipping"];
    rPaidBy = json["rpaidby"];
    totalItems = json["total_items"];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'test': test,
        'customer': customer,
        'warehouse': warehouse,
        'add_item': addItem,
        'product_id': productId,
        'product_type': productType,
        'product_code': productCode,
        'product_name': productName,
        'product_option': productOption,
        'product_comment': productComment,
        'serial': serial,
        'product_discount': productDiscount,
        'product_tax': productTax,
        'net_price': netPrice,
        'unit_price': unitPrice,
        'real_unit_price': realUnitPrice,
        'quantity': quantity,
        'product_unit': productUnit,
        'product_base_quantity': productBaseQuantity,
        'biller': biller,
        'pos_note': posNote,
        'staff_note': staffNote,
        'amount': amount,
        'balance_amount': balanceAmount,
        'paid_by': paidBy,
        'cc_no': ccNo,
        'paying_gift_card_no': payingGiftCardNo,
        'cc_holder': ccHolder,
        'cheque_no': chequeNo,
        'cc_month': ccMonth,
        'cc_year': ccYear,
        'cc_type': ccType,
        'cc_cvv2': ccCvv2,
        'payment_note': paymentNote,
        'order_tax': orderTax,
        'discount': discount,
        'shipping': shipping,
        'rpaidby': rPaidBy,
        'total_items': totalItems
      };
}
