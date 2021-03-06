class ReturnSale {
  String? id;
  String? date;
  String? referenceNo;
  String? customerId;
  String? customer;
  String? billerId;
  String? biller;
  String? warehouseId;
  String? note;
  String? staffNote;
  String? total;
  String? productDiscount;
  String? orderDiscountId;
  String? totalDiscount;
  String? orderDiscount;
  String? productTax;
  String? orderTaxId;
  String? orderTax;
  String? totalTax;
  String? shipping;
  String? grandTotal;
  String? saleStatus;
  String? paymentStatus;
  String? paymentTerm;
  String? dueDate;
  String? createdBy;
  String? updatedBy;
  String? updatedAt;
  String? totalItems;
  String? pos;
  String? paid;
  String? returnId;
  String? surcharge;
  String? attachment;
  String? returnSaleRef;
  String? saleId;
  String? returnSaleTotal;
  String? rounding;
  String? suspendNote;
  String? api;
  String? shop;
  String? addressId;
  String? reserveId;
  String? hash;
  String? manualPayment;
  String? cGst;
  String? sGst;
  String? iGst;
  String? paymentMethod;

  ReturnSale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    referenceNo = json['reference_no'];
    customerId = json['customer_id'];
    customer = json['customer'];
    billerId = json['biller_id'];
    biller = json['biller'];
    warehouseId = json['warehouse_id'];
    note = json['note'];
    staffNote = json['staff_note'];
    total = json['total'];
    productDiscount = json['product_discount'];
    orderDiscountId = json['order_discount_id'];
    totalDiscount = json['total_discount'];
    orderDiscount = json['order_discount'];
    productTax = json['product_tax'];
    orderTaxId = json['order_tax_id'];
    orderTax = json['order_tax'];
    totalTax = json['total_tax'];
    shipping = json['shipping'];
    grandTotal = json['grand_total'];
    saleStatus = json['sale_status'];
    paymentStatus = json['payment_status'];
    paymentTerm = json['payment_term'];
    dueDate = json['due_date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    totalItems = json['total_items'];
    pos = json['pos'];
    paid = json['paid'];
    returnId = json['return_id'];
    surcharge = json['surcharge'];
    attachment = json['attachment'];
    returnSaleRef = json['return_sale_ref'];
    saleId = json['sale_id'];
    returnSaleTotal = json['return_sale_total'];
    rounding = json['rounding'];
    suspendNote = json['suspend_note'];
    api = json['api'];
    shop = json['shop'];
    addressId = json['address_id'];
    reserveId = json['reserve_id'];
    hash = json['hash'];
    manualPayment = json['manual_payment'];
    cGst = json['cgst'];
    sGst = json['sgst'];
    iGst = json['igst'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['reference_no'] = referenceNo;
    data['customer_id'] = customerId;
    data['customer'] = customer;
    data['biller_id'] = billerId;
    data['biller'] = biller;
    data['warehouse_id'] = warehouseId;
    data['note'] = note;
    data['staff_note'] = staffNote;
    data['total'] = total;
    data['product_discount'] = productDiscount;
    data['order_discount_id'] = orderDiscountId;
    data['total_discount'] = totalDiscount;
    data['order_discount'] = orderDiscount;
    data['product_tax'] = productTax;
    data['order_tax_id'] = orderTaxId;
    data['order_tax'] = orderTax;
    data['total_tax'] = totalTax;
    data['shipping'] = shipping;
    data['grand_total'] = grandTotal;
    data['sale_status'] = saleStatus;
    data['payment_status'] = paymentStatus;
    data['payment_term'] = paymentTerm;
    data['due_date'] = dueDate;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['total_items'] = totalItems;
    data['pos'] = pos;
    data['paid'] = paid;
    data['return_id'] = returnId;
    data['surcharge'] = surcharge;
    data['attachment'] = attachment;
    data['return_sale_ref'] = returnSaleRef;
    data['sale_id'] = saleId;
    data['return_sale_total'] = returnSaleTotal;
    data['rounding'] = rounding;
    data['suspend_note'] = suspendNote;
    data['api'] = api;
    data['shop'] = shop;
    data['address_id'] = addressId;
    data['reserve_id'] = reserveId;
    data['hash'] = hash;
    data['manual_payment'] = manualPayment;
    data['cgst'] = cGst;
    data['sgst'] = sGst;
    data['igst'] = iGst;
    data['payment_method'] = paymentMethod;
    return data;
  }
}
