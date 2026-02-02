import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final AuthController authCtrl = Get.find<AuthController>();
  final SettingsController settingsCtrl = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // 🌙 THEME SECTION
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(
                () => SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text("Enable dark theme"),
                  secondary: Icon(
                    Icons.dark_mode_rounded,
                    color: settingsCtrl.isDarkMode.value
                        ? Colors.deepPurple
                        : Colors.grey,
                  ),
                  value: settingsCtrl.isDarkMode.value,
                  onChanged: (val) {
                    settingsCtrl.toggleTheme(val);
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔐 ACCOUNT SECTION
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text("Sign out from your account"),
                    onTap: () {
                      Get.defaultDialog(
                        title: "Confirm Logout",
                        middleText: "Are you sure you want to logout?",
                        textConfirm: "Yes",
                        textCancel: "No",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          authCtrl.logout();
                        },
                      );
                    },
                  ),
                  const Divider(height: 1),

                  // 🗑 CLEAR DATA
                  ListTile(
                    leading: const Icon(
                      Icons.delete_forever,
                      color: Colors.orange,
                    ),
                    title: const Text(
                      "Clear All Data",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: const Text(
                      "Delete products, sales & app settings",
                    ),
                    onTap: () {
                      Get.defaultDialog(
                        title: "Delete All Data?",
                        middleText:
                            "This will permanently delete all products, sales, and settings.",
                        textConfirm: "Delete",
                        textCancel: "Cancel",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          settingsCtrl.clearAllData();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ℹ FOOTER
            Text(
              "Inventory Management App",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              "Version 1.0.0",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
