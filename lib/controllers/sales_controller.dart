import 'package:get/get.dart';
import '../models/sale_model.dart';
import '../services/storage_service.dart';
import 'product_controller.dart';

class SalesController extends GetxController {
  var sales = <SaleModel>[].obs;
  final ProductController productController = Get.find();

  @override
  void onInit() {
    super.onInit();
    sales.value = StorageService.getSales();
  }

  void addSale(String productId, String productName, int qty) {
    // Find product
    var product = productController.products.firstWhereOrNull(
      (p) => p.id == productId,
    );

    if (product == null) {
      Get.snackbar("Error", "Product not found");
      return;
    }

    // Validation: quantity should be > 0
    if (qty <= 0) {
      Get.snackbar("Error", "Quantity must be greater than 0");
      return;
    }

    // Validation: enough stock?
    if (qty > product.stock) {
      Get.snackbar("Stock Error", "Only ${product.stock} items available");
      return;
    }

    // Create Sale
    SaleModel sale = SaleModel(
      productId: productId,
      productName: productName,
      quantity: qty,
      date: DateTime.now().toString(),
    );

    // Save sale
    sales.add(sale);
    StorageService.saveSales(sales);

    // Reduce stock automatically
    product.stock = product.stock - qty;
    StorageService.saveProducts(productController.products);

    // Low stock warning
    if (product.stock < 10) {
      Get.snackbar(
        "Low Stock Alert ⚠️",
        "${product.name} stock is low: ${product.stock}",
        duration: Duration(seconds: 3),
      );
    } else {
      Get.snackbar("Success", "Sale recorded successfully");
    }
  }
}
