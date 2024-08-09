import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/presentation/history/screen/history_screen.dart';
import 'package:rebuild_bank_sampah/presentation/home/screen/bottom_navigation.dart';
import 'package:rebuild_bank_sampah/presentation/home/screen/home_screen.dart';
import 'package:rebuild_bank_sampah/presentation/login/screen/login_screen.dart';
import 'package:rebuild_bank_sampah/presentation/profile/screen/profile_screen.dart';
import 'package:rebuild_bank_sampah/presentation/trash/screen/deposit_trash_screen.dart';
import 'package:rebuild_bank_sampah/presentation/splash/screen/splash_screen.dart';
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
  static const String withdrawFunds = "/withdraw-funds";


  static final routes = [
    GetPage(name: login, page : () => LoginScreen()),
     GetPage(name: bottomNavigation, page : () => BottomNavigation()),
    GetPage(name: splash, page : () => SplashScreen()),
    GetPage(name: home, page : () => HomeScreen()),
    GetPage(name: history, page : () => HistoryScreen()),
    GetPage(name: profile, page : () => ProfileScreen()),
    GetPage(name: setorSampah, page : () => SetorSampahScreen()),
    GetPage(name: withdrawFunds, page : () => WithdrawFundsScreen()),
    //cara menggunakan Binding
    //GetPage(name: login, page : () => LoginScreen(), binding: LoginBinding()),
  ];

}