import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/presentation/history/screen/history_screen.dart';
import 'package:rebuild_bank_sampah/presentation/home/screen/bottom_navigation.dart';
import 'package:rebuild_bank_sampah/presentation/home/screen/home_screen.dart';
import 'package:rebuild_bank_sampah/presentation/login/screen/login_screen.dart';
import 'package:rebuild_bank_sampah/presentation/order/screen/detail_order_screen.dart';
import 'package:rebuild_bank_sampah/presentation/order/screen/order_see_screen.dart';
import 'package:rebuild_bank_sampah/presentation/product/screen/add_product_screen.dart';
import 'package:rebuild_bank_sampah/presentation/profile/screen/profile_screen.dart';
import 'package:rebuild_bank_sampah/presentation/shop/screen/basket_screen.dart';
import 'package:rebuild_bank_sampah/presentation/shop/screen/checkout_screen.dart';
import 'package:rebuild_bank_sampah/presentation/product/screen/product_screen.dart';
import 'package:rebuild_bank_sampah/presentation/shop/screen/shopping_screen.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/add_deposit_trash_screen.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/customer/deposit_trash_customer_screen.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/deposit_trash_screen.dart';
import 'package:rebuild_bank_sampah/presentation/splash/screen/splash_screen.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/price_trash/add_price_trash_screen.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/price_trash/trash_price_screen.dart';
import 'package:rebuild_bank_sampah/presentation/withdraw/screen/withdraw_funds_screen.dart';



class AppRoutes {

  static const String main = "/";

  static const String bottomNavigation = "/bottom-navigation";
  static const String login = "/login";
  static const String splash = "/splash";
  static const String home = "/home";
  static const String history = "/history";
  static const String profile = "/profile";

  static const String setorSampah = "/setor-sampah";
  static const String priceTrash = "/price-sampah";
  static const String withdrawFunds = "/withdraw-funds";

  static const String shop = "/shop";
  static const String basket = "/basket";
  static const String checkout = "/checkout";
  static const String orderSee = "/order-see";
  static const String detailOrder = "/detail-order";

  static const String shopAdmin = "/shop-admin";
  static const String addProduct = "/add-product";
  static const String addTrashDeposit = "/add-trash-deposit";
  static const String customerTrashDeposit = "/customer-trash-product";
  static const String addTrashSuper = "/add-trash-super";




  static final routes = [
    GetPage(name: login, page : () => LoginScreen()),
    GetPage(name: bottomNavigation, page : () => BottomNavigation()),
    GetPage(name: splash, page : () => SplashScreen()),
    GetPage(name: home, page : () => HomeScreen()),
    GetPage(name: history, page : () => HistoryScreen()),
    GetPage(name: profile, page : () => ProfileScreen()),
    GetPage(name: setorSampah, page : () => SetorSampahScreen()),
    GetPage(name: withdrawFunds, page : () => WithdrawFundsScreen()),
    GetPage(name: shop, page : () => ShoppingScreen()),
    GetPage(name: basket, page : () => BasketScreen()),
    GetPage(name: checkout, page : () => CheckoutScreen()),
    GetPage(name: orderSee, page : () => OrderSeeScreen()),
    GetPage(name: detailOrder, page : () => DetailOrderScreen()),
    GetPage(name: shopAdmin, page : () => ProductScreen()),
    GetPage(name: addProduct, page : () => AddProductScreen()),
    GetPage(name: addTrashDeposit, page : () => AddDepositTrashScreen()),
    GetPage(name: customerTrashDeposit, page : () => DepositTrashCustomerScreen()),
    GetPage(name: priceTrash, page : () => TrashPriceScreen()),
    GetPage(name: addTrashSuper, page : () => AddPriceTrashScreen()),
    //cara menggunakan Binding
    //GetPage(name: login, page : () => LoginScreen(), binding: LoginBinding()),
  ];

}