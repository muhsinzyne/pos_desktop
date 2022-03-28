import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_details_controller.dart';

class RegisterDetailsView extends GetView<RegisterDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (() {
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
                                  "SALES (14/02/2022 06:31 - 12/03/2022 09:01)",
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
                          ]),
                    ),
                  ));
        }),
        child: Container(
            width: 40,
            color: Colors.green,
            child: const Icon(Icons.done_rounded)),
      ),
    );
  }
}
