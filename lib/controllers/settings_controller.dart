import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../routes/app_routes.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme if exists
    isDarkMode.value = StorageService.getThemeMode();
    _applyTheme(isDarkMode.value);
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    StorageService.saveThemeMode(value);
    _applyTheme(value);
  }

  void _applyTheme(bool dark) {
    Get.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
  }

  void clearAllData() async {
    await StorageService.clearAll();

    Get.snackbar(
      "Data Cleared",
      "All data deleted successfully",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
