import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';
import '../../routes/app_routes.dart';

class EditProductView extends StatelessWidget {
  EditProductView({super.key});

  final ProductController productCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    final int index = Get.arguments;
    final ProductModel product = productCtrl.products[index];

    final idCtrl = TextEditingController(text: product.id);
    final nameCtrl = TextEditingController(text: product.name);
    final categoryCtrl = TextEditingController(text: product.category);
    final priceCtrl = TextEditingController(text: product.price.toString());
    final stockCtrl = TextEditingController(text: product.stock.toString());

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Product",
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
                    backgroundColor: Color.fromARGB(255, 237, 236, 239),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    ProductModel updated = ProductModel(
                      id: idCtrl.text,
                      name: nameCtrl.text,
                      category: categoryCtrl.text,
                      price: double.parse(priceCtrl.text),
                      stock: int.parse(stockCtrl.text),
                      createdAt: product.createdAt,
                    );

                    productCtrl.updateProduct(index, updated);
                    Get.offAllNamed(AppRoutes.HOME);
                  },
                  child: const Text(
                    "Update Product",
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
