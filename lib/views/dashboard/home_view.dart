import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../routes/app_routes.dart';
import '../../models/product_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ProductController productCtrl = Get.find();
  final searchCtrl = TextEditingController();
  final selectedCategory = "All".obs;
  final selectedSort = "None".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Inventory Dashboard",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5F2EEA), Color(0xFF7B61FF)],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sell),
            onPressed: () => Get.toNamed(AppRoutes.SALES),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed(AppRoutes.SETTINGS),
          ),
        ],
      ),

      // ================= FAB =================
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6,
        backgroundColor: Colors.white, // 🤍 white fill
        icon: const Icon(
          Icons.add,
          color: Color(0xFF5F2EEA), // icon color (purple – professional)
        ),
        label: const Text(
          "Add Product",
          style: TextStyle(
            color: Color(0xFF5F2EEA), // text color
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () => Get.toNamed(AppRoutes.ADD_PRODUCT),
      ),

      // ================= BODY =================
      body: Obx(() {
        int totalProducts = productCtrl.products.length;
        int totalStock = productCtrl.products.fold(
          0,
          (sum, p) => sum + p.stock,
        );

        List<ProductModel> lowStock = productCtrl.lowStockProducts();

        List<ProductModel> filteredList = productCtrl.products.where((p) {
          return p.name.toLowerCase().contains(searchCtrl.text.toLowerCase());
        }).toList();

        if (selectedCategory.value != "All") {
          filteredList = filteredList
              .where((p) => p.category == selectedCategory.value)
              .toList();
        }

        if (selectedSort.value == "Price") {
          filteredList.sort((a, b) => a.price.compareTo(b.price));
        } else if (selectedSort.value == "Stock") {
          filteredList.sort((a, b) => a.stock.compareTo(b.stock));
        }

        List<ProductModel> recentProducts = productCtrl.products.reversed
            .take(5)
            .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= DASHBOARD =================
              Row(
                children: [
                  _summaryCard(
                    title: "Products",
                    value: totalProducts.toString(),
                    icon: Icons.inventory_2,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 14),
                  _summaryCard(
                    title: "Total Stock",
                    value: totalStock.toString(),
                    icon: Icons.bar_chart_rounded,
                    color: Colors.green,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ================= SEARCH =================
              TextField(
                controller: searchCtrl,
                onChanged: (_) => productCtrl.update(),
                decoration: InputDecoration(
                  hintText: "Search products",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ================= FILTER =================
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory.value,
                      decoration: _dropdownDecoration("Category"),
                      items:
                          [
                                "All",
                                "Grocery",
                                "Electronics",
                                "Stationery",
                                "Other",
                              ]
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (val) {
                        selectedCategory.value = val!;
                        productCtrl.update();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedSort.value,
                      decoration: _dropdownDecoration("Sort By"),
                      items: ["None", "Price", "Stock"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) {
                        selectedSort.value = val!;
                        productCtrl.update();
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              // ================= LOW STOCK =================
              _sectionHeader("Low Stock Alerts"),
              lowStock.isEmpty
                  ? const Text("No low stock items 🎉")
                  : Column(
                      children: lowStock.map((p) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                            title: Text(
                              p.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text("Stock: ${p.stock}"),
                          ),
                        );
                      }).toList(),
                    ),

              const SizedBox(height: 26),

              // ================= PRODUCTS =================
              _sectionHeader("All Products"),
              filteredList.isEmpty
                  ? const Text("No products found")
                  : Column(
                      children: filteredList.map((p) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
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
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "Stock: ${p.stock} | ₹${p.price} | ${p.category}",
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFF5F2EEA),
                              ),
                              onPressed: () => Get.toNamed(
                                AppRoutes.EDIT_PRODUCT,
                                arguments: productCtrl.products.indexOf(p),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

              const SizedBox(height: 26),

              // ================= RECENT =================
              _sectionHeader("Recently Added"),
              recentProducts.isEmpty
                  ? const Text("No recent products")
                  : Column(
                      children: recentProducts.map((p) {
                        return Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            title: Text(p.name),
                            subtitle: Text("Stock: ${p.stock}"),
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        );
      }),
    );
  }

  // ================= UI HELPERS =================

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
