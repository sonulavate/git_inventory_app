import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = StorageService.isLoggedIn();
  }

  void register(String username, String password) async {
    UserModel user = UserModel(username: username, password: password);
    await StorageService.saveUser(user);
    await StorageService.setLogin(true);
    isLoggedIn.value = true;
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  void login(String username, String password) {
    UserModel? user = StorageService.getUser();

    if (user != null &&
        user.username == username &&
        user.password == password) {
      StorageService.setLogin(true);
      isLoggedIn.value = true;
      Get.offAllNamed(AppRoutes.HOME);
    } else {
      Get.snackbar("Error", "Invalid Credentials");
    }
  }

  void logout() async {
    await StorageService.setLogin(false);
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}
