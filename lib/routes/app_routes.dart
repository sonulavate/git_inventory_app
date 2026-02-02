import 'package:get/get.dart';
import '../views/auth/splash_view.dart';
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';
import '../views/dashboard/home_view.dart';
import '../views/product/add_product_view.dart';
import '../views/product/edit_product_view.dart';
import '../views/sales/sales_view.dart';
import '../views/settings/settings_view.dart';

class AppRoutes {
  static const SPLASH = "/splash";
  static const LOGIN = "/login";
  static const REGISTER = "/register";
  static const HOME = "/home";
  static const ADD_PRODUCT = "/add-product";
  static const EDIT_PRODUCT = "/edit-product";
  static const SALES = "/sales";
  static const SETTINGS = "/settings";

  static List<GetPage> pages = [
    GetPage(name: SPLASH, page: () => SplashView()),
    GetPage(name: LOGIN, page: () => LoginView()),
    GetPage(name: REGISTER, page: () => RegisterView()),
    GetPage(name: HOME, page: () => HomeView()),
    GetPage(name: ADD_PRODUCT, page: () => AddProductView()),
    GetPage(name: EDIT_PRODUCT, page: () => EditProductView()),
    GetPage(name: SALES, page: () => SalesView()),
    GetPage(name: SETTINGS, page: () => SettingsView()),
  ];
}
