import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/sales_controller.dart';
import '../../models/product_model.dart';

class SalesView extends StatelessWidget {
  SalesView({super.key});

  final SalesController salesCtrl = Get.find();
  final ProductController productCtrl = Get.find();
  final qtyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Sales",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5F2EEA), Color(0xFF7B61FF)],
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= PRODUCT LIST =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: const Text(
              "Sell Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: productCtrl.products.length,
                itemBuilder: (context, index) {
                  ProductModel p = productCtrl.products[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        p.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Stock: ${p.stock}",
                        style: TextStyle(
                          color: p.stock < 10
                              ? Colors.red
                              : Colors.grey.shade700,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.sell, color: Color(0xFF5F2EEA)),
                        onPressed: () {
                          qtyCtrl.clear();

                          Get.defaultDialog(
                            title: "Sell ${p.name}",
                            titleStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            content: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextField(
                                controller: qtyCtrl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Quantity",
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            textConfirm: "Sell",
                            textCancel: "Cancel",
                            confirmTextColor: Colors.white,
                            buttonColor: const Color(0xFF5F2EEA),
                            onConfirm: () {
                              if (qtyCtrl.text.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please enter quantity",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                return;
                              }

                              int qty = int.tryParse(qtyCtrl.text) ?? 0;
                              salesCtrl.addSale(p.id, p.name, qty);

                              qtyCtrl.clear();
                              Get.back();
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // ================= SALES HISTORY =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: const Text(
              "Sales History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: salesCtrl.sales.length,
                itemBuilder: (context, index) {
                  var s = salesCtrl.sales[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.receipt_long,
                        color: Color(0xFF5F2EEA),
                      ),
                      title: Text(
                        s.productName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Qty: ${s.quantity} • ${s.date}",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
