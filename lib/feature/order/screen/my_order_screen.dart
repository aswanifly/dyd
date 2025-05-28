import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/feature/cart/view-model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/order_card_widget.dart';
import '../widget/order_chip_widget.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final CartViewModel cartViewModel = Get.put(
    CartViewModel(),
  );

  @override
  void initState() {
    // Reset filter to deselect all chips on screen reopen
    cartViewModel.fGetOrderList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: const Text("My Orders"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildOrderStatusWidget(),
          Obx(() {
            if (cartViewModel.kCartsLoading.value == Status.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Failed to load orders",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => cartViewModel.fGetOrderList(context),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            } else if (cartViewModel.orderList.isEmpty) {
              return const Center(child: Text("No orders found"));
            }

            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: cartViewModel.orderList.length,
                itemBuilder: (BuildContext context, index) {
                  final orderModel = cartViewModel.orderList[index];
                  return OrderCardWidget(orderModel: orderModel);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildOrderStatusWidget() {
    const List<String> statusFilters = [
      "All",
      "Confirmed",
      "InTransit",
      "Returned",
      "Cancelled",
      "Completed"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: statusFilters.map((type) {
              bool isActive =
                  (type == "All" && cartViewModel.orderFilters.value == "") ||
                      (cartViewModel.orderFilters.value == type);

              return GestureDetector(
                onTap: () {
                  if (isActive) {
                    cartViewModel.orderFilters.value = "";
                  } else {
                    cartViewModel.orderFilters.value =
                        (type == "All") ? "" : type;
                  }

                  cartViewModel.fGetOrderList(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OrderChipWidget(
                    title: type,
                    isActive: isActive,
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }
}
