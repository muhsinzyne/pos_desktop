import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/close_register_controller.dart';

class CloseRegisterView extends GetView<CloseRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (builder) => AlertDialog(
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "CLOSE REGISTER (14/02/2022 06:31 - 17/03/2022 09:37)",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.print,
                                              color: Colors.black,
                                            ),
                                            Text("Print")
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          size: 30,
                                          color: Colors.black,
                                        )),
                                  ],
                                )
                              ],
                            ),
                            const Divider(),
                            RichText(
                                text: const TextSpan(
                                    text: "Please review the details below as ",
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(
                                    text: "paid (total)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ])),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Cash in hand:"),
                                Text("SR 500.00"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Cash Payment:"),
                                Text("SR 1,820.90 (SR 2,281.90)"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Cheque Payment:"),
                                Text("0.00 (0.00)"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Credit Card Payment:"),
                                Text("0.00 (0.00)"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Gift Card Payment:"),
                                Text("0.00 (0.00)"),
                              ],
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Total Sales:"),
                                Text("SR 1,820.90 (SR 2,281.90)"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Refunds:"),
                                Text("SR -341.00 (0.00)"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Returns:"),
                                Text("0.00"),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Expenses:"),
                                Text("0.00 (0.00)"),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Total Cash:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "SR 1,979.90",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text(
                                      "Total Cash *",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: TextFormField(
                                      controller: controller.totalCash,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text(
                                      "Total Credit Card Slips *",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: TextFormField(
                                      controller: controller.totalCards,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
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
                                      "Total Cheques *",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: TextFormField(
                                      controller: controller.totalCheques,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                            const Divider(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Close Register")),
                            ),
                          ]),
                    ),
                  ));
        },
        child: Container(
          alignment: Alignment.center,
          width: 40,
          color: Colors.red,
          child: const Icon(Icons.close_rounded),
        ),
      ),
    );
  }
}
