import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/presentation/login/screen/login_screen.dart';



class AppRoutes {

  static const String main = "/";

  static const String login = "/login";


  static final routes = [
    GetPage(name: login, page : () => LoginScreen()),
    //cara menggunakan Binding
    //GetPage(name: login, page : () => LoginScreen(), binding: LoginBinding()),
  ];

}