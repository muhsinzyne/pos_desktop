import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_expense_controller.dart';

class AddExpenseView extends GetView<AddExpenseController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // shrinkWrap: true,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "ADD EXPENSE",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 30,
                                    color: Colors.black,
                                  ))
                            ]),
                        const Divider(),
                        const ListTile(
                          title: Text(
                            "Please fill in the information below. The field labels marked with * are required input fields.",
                            // style: TextStyle(
                            //   fontSize: 30,
                            // )
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const ListTile(
                                    title: Text(
                                      "Date *",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: TextFormField(
                                      controller: controller.date,
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        controller.presentDatePicker(context);
                                      },
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.zero))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const ListTile(
                                    title: Text(
                                      "Category",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DropdownButtonFormField<CategoryOption>(
                                    onChanged: (value) {
                                      // print(value);
                                      controller.selectedCategory = value!.key;
                                    },
                                    items: controller.categories
                                        .map((selectedType) {
                                      return DropdownMenuItem<CategoryOption>(
                                        child: Text(
                                          selectedType.fullName,
                                        ),
                                        value: selectedType,
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.zero))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const ListTile(
                          title: Text(
                            "Store",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownButtonFormField<Stores>(
                          onChanged: (value) {
                            controller.selectedStore = value!.key;
                          },
                          items: controller.stores.map((selectedType) {
                            return DropdownMenuItem<Stores>(
                              child: Text(
                                selectedType.fullName,
                              ),
                              value: selectedType,
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.zero))),
                        ),
                        const ListTile(
                          title: Text(
                            "Reference",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextFormField(
                            controller: controller.reference,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero))),
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "Amount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: TextFormField(
                            controller: controller.amount,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero))),
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            "Attachement",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  // controller: controller.attachement,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.zero))),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.folder_open,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Browse",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              controller.vaidate();
                            },
                            child: const Text("Add Expense")),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Container(
          alignment: Alignment.center,
          width: 40,
          color: Colors.red,
          child: const Text(
            '\$',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
