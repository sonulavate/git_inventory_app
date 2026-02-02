import 'package:final_inventory_app/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/storage_service.dart';
import 'controllers/auth_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/sales_controller.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(SalesController());
  Get.put(SettingsController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsCtrl = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settingsCtrl.isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      getPages: AppRoutes.pages,
    );
  }
}
