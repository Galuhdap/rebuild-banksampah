import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/presentation/home/screen/home_screen.dart';
import 'package:rebuild_bank_sampah/presentation/login/screen/login_screen.dart';
import 'package:rebuild_bank_sampah/presentation/splash/screen/splash_screen.dart';



class AppRoutes {

  static const String main = "/";

  static const String login = "/login";
  static const String splash = "/splash";
  static const String home = "/home";


  static final routes = [
    GetPage(name: login, page : () => LoginScreen()),
    GetPage(name: splash, page : () => SplashScreen()),
    GetPage(name: home, page : () => HomeScreen()),
    //cara menggunakan Binding
    //GetPage(name: login, page : () => LoginScreen(), binding: LoginBinding()),
  ];

}