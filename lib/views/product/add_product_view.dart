import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class AddProductView extends StatelessWidget {
  AddProductView({super.key});

  final ProductController productCtrl = Get.find();

  final idCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();

  // Helper: check duplicate ID
  bool _isDuplicateId(String id) {
    return productCtrl.products.any((p) => p.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Add Product",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 14),
            ],
          ),
          child: Column(
            children: [
              _inputField(
                controller: idCtrl,
                label: "Product ID",
                icon: Icons.qr_code,
              ),
              const SizedBox(height: 14),

              _inputField(
                controller: nameCtrl,
                label: "Product Name",
                icon: Icons.inventory_2,
              ),
              const SizedBox(height: 14),

              _inputField(
                controller: categoryCtrl,
                label: "Category",
                icon: Icons.category,
              ),
              const SizedBox(height: 14),

              _inputField(
                controller: priceCtrl,
                label: "Price",
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 14),

              _inputField(
                controller: stockCtrl,
                label: "Stock Quantity",
                icon: Icons.storage,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 26),

              // ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 244, 244, 246),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    // -------- VALIDATIONS --------
                    if (idCtrl.text.isEmpty ||
                        nameCtrl.text.isEmpty ||
                        categoryCtrl.text.isEmpty ||
                        priceCtrl.text.isEmpty ||
                        stockCtrl.text.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "All fields are required",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    if (_isDuplicateId(idCtrl.text)) {
                      Get.snackbar(
                        "Error",
                        "Product ID already exists!",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    double? price = double.tryParse(priceCtrl.text);
                    int? stock = int.tryParse(stockCtrl.text);

                    if (price == null || stock == null) {
                      Get.snackbar(
                        "Error",
                        "Enter valid numbers",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    // -------- LOW STOCK WARNING --------
                    if (stock < 10) {
                      Get.snackbar(
                        "Low Stock Alert",
                        "Stock is below 10. This item will appear in alerts.",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }

                    ProductModel product = ProductModel(
                      id: idCtrl.text,
                      name: nameCtrl.text,
                      category: categoryCtrl.text,
                      price: price,
                      stock: stock,
                      createdAt: DateTime.now().toString(),
                    );

                    productCtrl.addProduct(product);

                    idCtrl.clear();
                    nameCtrl.clear();
                    categoryCtrl.clear();
                    priceCtrl.clear();
                    stockCtrl.clear();

                    Get.snackbar(
                      "Success",
                      "Product added successfully",
                      snackPosition: SnackPosition.BOTTOM,
                    );

                    Get.offAllNamed(AppRoutes.HOME);
                  },
                  child: const Text(
                    "Save Product",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= INPUT FIELD =================
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
