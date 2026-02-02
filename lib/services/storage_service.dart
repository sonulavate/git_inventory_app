import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/sale_model.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static const String userKey = "user";
  static const String loginKey = "isLoggedIn";
  static const String productsKey = "products";
  static const String salesKey = "sales";
  static const _themeKey = "isDarkMode";

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // USER AUTH
  static Future<void> saveUser(UserModel user) async {
    await _prefs!.setString(userKey, user.toJson());
  }

  static UserModel? getUser() {
    String? data = _prefs!.getString(userKey);
    if (data == null) return null;
    return UserModel.fromJson(data);
  }

  static Future<void> setLogin(bool value) async {
    await _prefs!.setBool(loginKey, value);
  }

  static bool isLoggedIn() {
    return _prefs!.getBool(loginKey) ?? false;
  }

  // PRODUCTS
  static Future<void> saveProducts(List<ProductModel> products) async {
    List<String> list = products.map((p) => p.toJson()).toList();
    await _prefs!.setStringList(productsKey, list);
  }

  static List<ProductModel> getProducts() {
    List<String>? list = _prefs!.getStringList(productsKey);
    if (list == null) return [];
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  // SALES
  static Future<void> saveSales(List<SaleModel> sales) async {
    List<String> list = sales.map((s) => s.toJson()).toList();
    await _prefs!.setStringList(salesKey, list);
  }

  static List<SaleModel> getSales() {
    List<String>? list = _prefs!.getStringList(salesKey);
    if (list == null) return [];
    return list.map((e) => SaleModel.fromJson(e)).toList();
  }

  static Future<void> clearAll() async {
    await _prefs!.clear();
  }

  static Future<void> saveThemeMode(bool isDark) async {
    await _prefs!.setBool(_themeKey, isDark);
  }

  static bool getThemeMode() {
    return _prefs?.getBool(_themeKey) ?? false;
  }
}
