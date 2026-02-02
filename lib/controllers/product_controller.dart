import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/storage_service.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    products.value = StorageService.getProducts();
  }

  void addProduct(ProductModel product) {
    products.add(product);
    StorageService.saveProducts(products);
  }

  void updateProduct(int index, ProductModel product) {
    products[index] = product;
    StorageService.saveProducts(products);
  }

  void deleteProduct(int index) {
    products.removeAt(index);
    StorageService.saveProducts(products);
  }

  List<ProductModel> lowStockProducts() {
    return products.where((p) => p.stock < 10).toList();
  }
}
