// ignore_for_file: prefer_const_constructors

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:posdelivery/models/response/customer/customer_group.dart';
import 'package:posdelivery/models/response/customer/price_group.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:searchfield/searchfield.dart';
import '../controllers/sales_point_controller.dart';

class SalesPointView extends GetView<SalesPointController> {
  const SalesPointView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: const Color(0xFFDBDADA),
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          SizedBox(
            height: 36,
            // color: const Color(0xFFEEEEEE),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 76,
                  child: Container(
                    color: Colors.white,
                    child: Obx(
                      () {
                        return DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItems: false,
                          items: controller.customerListString,
                          onChanged: (value) {
                            controller.changeCustomer(value!);
                          },
                          selectedItem: controller.selectedCustomerName.value,
                          showSearchBox: true,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 24,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (() {}),
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.remove_red_eye_sharp,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: AddCustomerButton(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 36,
            // color: const Color(0xFFEEEEEE),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Obx(
                      () {
                        return Container(
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showSelectedItems: false,
                            items: controller.warehouses,
                            onChanged: (value) {
                              controller.changeWarehouse(value!);
                            },
                            selectedItem: controller.cWareHouseName,
                            showSearchBox: false,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 36,
            // color: const Color(0xFFEEEEEE),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Expanded(
                    flex: 92,
                    child: Container(
                      //height: 300,
                      color: Colors.white,
                      child: SearchField<Product>(
                        controller: controller.searchController,
                        onSuggestionTap: (value) {
                          controller.addProductOnClick(value.item!);
                        },
                        itemHeight: 35,
                        searchInputDecoration: const InputDecoration(
                          hintText: "Scan/Search product by name/code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          isCollapsed: true,
                          contentPadding: EdgeInsets.all(11),
                        ),
                        suggestions: controller.product
                            .map(
                              (e) => SearchFieldListItem<Product>(
                                e.label.toString(),
                                item: e,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 8,
                  child: AddProductButton(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.47,
              child: Column(
                children: [
                  Container(
                    height: 30,
                    color: const Color(0xFF5D25DF),
                    child: Row(children: const [
                      Expanded(
                          flex: 8,
                          child: Center(
                            child: Text(
                              "Product",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                      Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                      Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              "Qty",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                      Expanded(
                          flex: 3,
                          child: Center(
                            child: Text(
                              "Subtotal",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Icon(
                            Icons.delete_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Expanded(
              flex: 7,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.47,
                child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.selectedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            //top: BorderSide(width: 1.0, color: Colors.black12),
                            left: BorderSide(width: 1.0, color: Colors.black12),
                            right:
                                BorderSide(width: 1.0, color: Colors.black12),
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              color: controller.selectedProducts[index].row!
                                          .quantity !=
                                      0
                                  ? Colors.transparent
                                  : Colors.redAccent[400],
                              child: Row(children: [
                                Expanded(
                                    flex: 8,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        child: Text(
                                          controller
                                              .selectedProducts[index].label!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )),
                                VerticalDivider(
                                  color: Colors.black26,
                                  thickness: 0.5,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text(
                                        controller
                                            .selectedProducts[index].row!.price
                                            .toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                VerticalDivider(
                                  color: Colors.black26,
                                  thickness: 0.5,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        //     color: Colors.white,
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white)),
                                          ),
                                          initialValue: controller
                                              .selectedProducts[index].row!.qty
                                              .toString(),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            controller.checkAvailableQuantity(
                                                index, value);
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ], // Only numbers can be entered
                                        ),
                                      ),
                                      // Text(
                                      //   controller
                                      //       .selectedProducts[index].row!.qty
                                      //       .toString(),
                                      //   textAlign: TextAlign.center,
                                      //   style: TextStyle(
                                      //       color: Colors.black87,
                                      //       fontWeight: FontWeight.w500),
                                      //  ),
                                    )),
                                VerticalDivider(
                                  color: Colors.black26,
                                  thickness: 0.5,
                                ),
                                Obx(
                                  () => Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          controller.selectedProducts[index]
                                              .row!.price!
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ),
                                VerticalDivider(
                                  color: Colors.black26,
                                  thickness: 0.5,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(Icons.close_rounded),
                                        color: Colors.black,
                                        iconSize: 18,
                                        onPressed: () {
                                          controller.removeProduct(controller
                                              .selectedProducts[index]);
                                        }),
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
          const Divider(),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Items"),
                      Text(
                        "0 (0.00)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Total"),
                      Text(
                        "0.00",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ]),
                const Divider(),
                Row(children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Order Tax"),
                      Text(
                        "0.00",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Discount"),
                      Text(
                        "(0.00) 0.00",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                ]),
              ],
            ),
          ),
          Container(
            height: 30,
            alignment: Alignment.center,
            color: const Color(0xFF222220),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Total Payable",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "0.00",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Obx(() => SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Container(
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: const Text(
                          "Suspend",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      child: Container(
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        if (controller.paymentFlag.value) {
                          showDialog(
                              context: context,
                              builder: (builder) => PaymentPopup());
                        }
                      },
                      child: Container(
                        color: controller.paymentFlag.value
                            ? Colors.green
                            : Colors.grey[600],
                        alignment: Alignment.center,
                        child: const Text(
                          "Payment",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}

class PaymentPopup extends StatelessWidget {
  const PaymentPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "FINALIZE SALE",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    ))
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Biller",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextField(
                            decoration: InputDecoration(
                                hintText: "DEMO BILLER",
                                border: OutlineInputBorder()),
                          ),
                          Row(
                            children: const [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextField(
                                    minLines: 5,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        hintText: "Sale Note",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextField(
                                    minLines: 5,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                        hintText: "Staff Note",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFB4B4B4), width: 0.5),
                                color: Color.fromARGB(255, 231, 231, 231)),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text("Amount",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: const TextField(
                                            decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 3),
                                          border: OutlineInputBorder(),
                                        )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text("Paying By",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          )),
                                      subtitle: Container(
                                        height: 40,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: const TextField(
                                            decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 3),
                                          border: OutlineInputBorder(),
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: const Text("Payment Note",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                  subtitle: Container(
                                    color: Colors.white,
                                    child: TextField(
                                      minLines: 2,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0))),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: const [
                                  Icon(
                                    Icons.add,
                                  ),
                                  Text("Add More Payments")
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Total Items",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "2",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                              const VerticalDivider(),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Total Payable",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "100.00",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Total Paying",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "100.00",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                              const VerticalDivider(),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Balance",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "0.00",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                            ],
                          )
                        ],
                      ),
                    )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        "Quick Cash",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.blue,
                        title: const Text(
                          "199",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.amber,
                        title: const Text(
                          "10",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.amber,
                        title: const Text(
                          "20",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.amber,
                        title: const Text(
                          "50",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.amber,
                        title: const Text(
                          "100",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.amber,
                        title: const Text(
                          "500",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.amber,
                        title: const Text(
                          "1000",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.amber,
                        title: const Text(
                          "5000",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ListTile(
                        onTap: (() {}),
                        tileColor: Colors.red,
                        title: const Text(
                          "Clear",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey,
              height: 1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class AddCustomerButton extends GetView<SalesPointController> {
  const AddCustomerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SalesPointController controller = SalesPointController();
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (builder) => AlertDialog(
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.addFromKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("ADD CUSTOMER"),
                                  IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                      ))
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Customer Group *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: DropdownButtonFormField<
                                            CustomerGroups>(
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            //filled: true,
                                            //fillColor: Colors.red,
                                            border: OutlineInputBorder(),
                                            // labelText: 'customer_group'.tr,
                                          ),
                                          isExpanded: true,
                                          value:
                                              controller.cCustomerGroup.value,
                                          items: (controller.customerPriceGroup
                                                  .value.customerGroups!
                                                  .map(buildCustomerGroup))
                                              .toList(),
                                          onChanged: (CustomerGroups? value) {
                                            controller
                                                .onChangeCustomerGroup(value!);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Price Group",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: DropdownButtonFormField<
                                            PriceGroups>(
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3,
                                            ),
                                            //filled: true,
                                            //fillColor: Colors.red,
                                            // labelText: 'price_group'.tr,
                                            border: OutlineInputBorder(),
                                          ),
                                          isExpanded: true,
                                          value: controller.cPriceGroup.value,
                                          items: (controller.customerPriceGroup
                                                      .value.priceGroups
                                                      ?.map(
                                                          buildPriceGroupItem) ??
                                                  [])
                                              .toList(),
                                          onChanged: (PriceGroups? value) {
                                            controller
                                                .onChangePriceGroup(value!);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Company *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.company,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Postal Code",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.pCode,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Name *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.cName,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Country",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.country,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "VAT Number",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.vatNo,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Customer Custom Field 1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.custom1,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  // Expanded(
                                  //   child: ListTile(
                                  //     title: const Text(
                                  //       "GST Number",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //     subtitle: SizedBox(
                                  //       height: 30,
                                  //       child: TextFormField(
                                  //         controller: controller.gstNo,
                                  //         decoration: const InputDecoration(
                                  //             contentPadding:
                                  //                 EdgeInsets.symmetric(
                                  //               horizontal: 8,
                                  //               vertical: 3,
                                  //             ),
                                  //             border: OutlineInputBorder()),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Email Address *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.email,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Phone *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: controller.phone,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "Address *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.address,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "City *",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.city,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "State",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: SizedBox(
                                        height: 30,
                                        child: TextFormField(
                                          controller: controller.state,
                                          decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                              ElevatedButton(
                                  onPressed: controller.actionOnSaveRequest,
                                  child: const Text("Add Customer"))
                              // GridView(
                              //     shrinkWrap: true,
                              //     physics: const ScrollPhysics(),
                              //     gridDelegate:
                              //         const SliverGridDelegateWithFixedCrossAxisCount(
                              //             crossAxisCount: 2),
                              //     children: const [
                              //       ListTile(
                              //         title: Text(
                              //           "Customer Group *",
                              //           style: TextStyle(fontWeight: FontWeight.bold),
                              //         ),
                              //         subtitle: TextField(
                              //           decoration: InputDecoration(
                              //               border: OutlineInputBorder()),
                              //         ),
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           "Customer Group *",
                              //           style: TextStyle(fontWeight: FontWeight.bold),
                              //         ),
                              //         subtitle: TextField(
                              //           decoration: InputDecoration(
                              //               border: OutlineInputBorder()),
                              //         ),
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           "Customer Group *",
                              //           style: TextStyle(fontWeight: FontWeight.bold),
                              //         ),
                              //         subtitle: TextField(
                              //           decoration: InputDecoration(
                              //               border: OutlineInputBorder()),
                              //         ),
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           "Customer Group *",
                              //           style: TextStyle(fontWeight: FontWeight.bold),
                              //         ),
                              //         subtitle: TextField(
                              //           decoration: InputDecoration(
                              //               border: OutlineInputBorder()),
                              //         ),
                              //       ),
                              //       ListTile(
                              //         title: Text(
                              //           "Customer Group *",
                              //           style: TextStyle(fontWeight: FontWeight.bold),
                              //         ),
                              //         subtitle: TextField(
                              //           decoration: InputDecoration(
                              //               border: OutlineInputBorder()),
                              //         ),
                              //       ),
                              //     ]),
                            ]),
                      ),
                    ),
                  ),
                ));
      },
      child: Container(
        height: 36,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: const Icon(
          Icons.add_circle,
          color: Colors.blue,
        ),
      ),
    );
  }

  DropdownMenuItem<CustomerGroups> buildCustomerGroup(CustomerGroups item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.name.toString().toUpperCase(),
        ),
      );

  DropdownMenuItem<PriceGroups> buildPriceGroupItem(PriceGroups item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.name.toString().toUpperCase(),
        ),
      );
}

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (builder) => AlertDialog(
                  content: SizedBox(
                      width: MediaQuery.of(context).size.width * .4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("ADD PRODUCT MANUALLY"),
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 30,
                                  ))
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Product Code * ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ));
      },
      child: Container(
        height: 36,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: const Icon(
          Icons.add_circle,
          color: Colors.blue,
        ),
      ),
    );
  }
}
