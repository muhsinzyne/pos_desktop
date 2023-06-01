class OrderAddRequest {
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
  OrderAddRequest();
  OrderAddRequest.fromJSON(Map<String, dynamic> parsedJson) {
    test = parsedJson['test'];
  }

  OrderAddRequest.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    warehouse = json['warehouse'];
    addItem = json['addItem'];
    productId = json['productId'];
    productType = json['productType'];
    productCode = json['productCode'];
    productName = json['productName'];
    productOption = json['productOption'];
    productComment = json['productComment'];
    serial = json['serial'];
    productDiscount = json['productDiscount'];
    productTax = json['productTax'];
    netPrice = json['netPrice'];
    unitPrice = json['unitPrice'];
    realUnitPrice = json['realUnitPrice'];
    quantity = json['quantity'];
    productUnit = json['productUnit'];
    productBaseQuantity = json['productBaseQuantity'];
    biller = json['biller'];
    posNote = json['posNote'];
    staffNote = json['staffNote'];
    amount = json['amount'];
    balanceAmount = json['balanceAmount'];
    paidBy = json['paidBy'];
    ccNo = json['ccNo'];
    payingGiftCardNo = json['payingGiftCardNo'];
    ccHolder = json['ccHolder'];
    chequeNo = json['chequeNo'];
    ccMonth = json['ccMonth'];
    ccYear = json['ccYear'];
    ccType = json['ccType'];
    orderTax = json['orderTax'];
    discount = json['disount'];
    shipping = json['shipping'];
    rPaidBy = json['rPaidBy'];
    totalItems = json['totalItems'];
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
