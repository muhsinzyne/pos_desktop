import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../sales_point/controllers/sales_point_controller.dart';
import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SalesPointController sController = Get.find<SalesPointController>();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        color: const Color(0xFFDBDADA),
        child: Row(children: [
          Expanded(
            flex: 2,
            child: DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.amber,
                    child: TabBar(
                      labelPadding: EdgeInsets.zero,
                      indicator: const BoxDecoration(
                        color: Colors.green,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Colors.white))),
                            alignment: Alignment.center,
                            child: const Text(
                              "Top Sellers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Colors.white))),
                            child: const Text(
                              "Category",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Tab(
                          child: Text(
                            "Brands",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: TabBarView(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.white,
                          child: Obx(() => GridView.builder(
                                controller: controller.scrollControllerProducts,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5),
                                itemCount: controller.productList.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    sController.addProductOnClick(
                                        controller.productList[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.red,
                                          child: Text(index.toString()),
                                        ),
                                        Text(
                                          controller.productList[index].label
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(),
                        GridTest(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            // color: Colors.grey,
            child: Container(),
          )),
        ]),
      ),
    );
  }
}

class GridTest extends StatefulWidget {
  const GridTest({Key? key}) : super(key: key);

  @override
  State<GridTest> createState() => _GridTestState();
}

class _GridTestState extends State<GridTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemCount: 30,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.red,
                  child: Text(index.toString()),
                ),
                Text(
                  "LIPTON GREEN TEA {$index}",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
