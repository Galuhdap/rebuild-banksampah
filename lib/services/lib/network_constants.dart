import 'package:rebuild_bank_sampah/services/report/model/request/get_data_report_trash_request.dart';

class NetworkConstants {
  //static const String BASE_URL = "https://dev.api.banksampah.techlinesolution.site/";
  static const String BASE_URL = "http://77.37.44.223:3000/";
  //static const String BASE_URL_DEV = "https://localhost:3000/";
  //static const String BASE_URL_PROD = "https://dev.api.enthusias.id";

  //login
  static const String POST_LOGIN_URL = BASE_URL + "api/login";
  static const String POST_REGISTER_CUSTOMER_URL =
      BASE_URL + "api/register-inactive";
  static const String GET_REGISTER_URL = BASE_URL + "api/super/users";
  static const String GET_ROLE_URL = BASE_URL + "api/super/role";
  static const String POST_REGISTER_URL = BASE_URL + "api/super/register";
  static const String POST_FORGOT_PASSWORD_URL =
      BASE_URL + "api/forgot-password";
  static String DELETE_REGISTER_URL(String id) {
    return BASE_URL + "api/super/users/$id";
  }

  static String UPDATE_REGISTER_URL(String id) {
    return BASE_URL + "api/super/users/$id";
  }

  //trash
  static const String GET_TRASH_URL = BASE_URL + "api/weigher/trash";
  static const String GET_TRASH_CUSTOMER_URL = BASE_URL + "api/customer/trash";
  static const String GET_TRASH_SUPER_URL = BASE_URL + "api/super/trash";
  static const String GET_DEPOSIT_TRASH_URL =
      BASE_URL + "api/weigher/trash/deposit";
  static const String GET_USER_DEPOSIT_TRASH_URL =
      BASE_URL + "api/weigher/users";
  static const String POST_DEPOSIT_TRASH_URL =
      BASE_URL + "api/weigher/trash/deposit";
  static const String GET_SUPER_ADMIN_DEPOSIT_TRASH_URL =
      BASE_URL + "api/super/trash/deposit";

  static String DELETE_DEPOSIT_TRASH_URL(String id) {
    return BASE_URL + "api/weigher/trash/deposit/$id";
  }

  static String PUT_DEPOSIT_TRASH_URL(String id) {
    return BASE_URL + "api/weigher/trash/deposit/$id";
  }

  static String PUT_DEPOSIT_SUPER_ADMIN_TRASH_URL(String id) {
    return BASE_URL + "api/super/trash/deposit/$id";
  }

  static String DELETE_PRICE_TRASH_URL(String id) {
    return BASE_URL + "api/super/trash/$id";
  }

  static String GET_CUSTOMER_DEPOSIT_TRASH_URL(String id) {
    return BASE_URL + "api/customer/deposit/$id";
  }

  static String EDIT_PRICE_TRASH_URL(String id) {
    return BASE_URL + "api/super/trash/$id";
  }

  static const String PUT_STATUS_DEPOSIT_URL =
      BASE_URL + "api/customer/deposit/update-status";

  static const String PUT_STATUS_REGISTER_SUPER_URL =
      BASE_URL + "api/super/user-status";

  //super
  static const String POST_SUPER_TRASH_URL = BASE_URL + "api/super/trash";

  //profile

  static String GET_CUSTOMER_BALANCE_URL(String id) {
    return BASE_URL + "api/customer/balance/$id";
  }

  static String GET_PROFILE_CUSTOMER_URL(String id) {
    return BASE_URL + "api/get-profile/$id";
  }

  static const String GET_SUMMARY_WEIGHET_URL =
      BASE_URL + "api/weigher/summary";

  static const String GET_SUMMARY_ADMIN_KOPRASI_URL =
      BASE_URL + "api/admin/balance";

  //Product
  static const String GET_PRODUCT_URL = BASE_URL + "api/admin/products";
  static const String POST_PRODUCT_URL = BASE_URL + "api/admin/products";
  static String PUT_PRODUCT_URL(String id) {
    return BASE_URL + "api/admin/products/$id";
  }

  static String DELETE_PRODUCT_URL(String id) {
    return BASE_URL + "api/admin/products/$id";
  }

  static const String POST_PRODUCT_BUY_CUSTOMER_URL =
      BASE_URL + "api/customer/transaction";
  static const String GET_PRODUCT_CUSTOMER_URL =
      BASE_URL + "api/customer/products";

  //Order
  static const String GET_ORDER_ADMIN_URL = BASE_URL + "api/admin/transactions";
  static String GET_ORDER_CUSTOMER_URL(String id) {
    return BASE_URL + "api/customer/transaction/$id";
  }

  static const String POST_ORDER_ADMIN_URL =
      BASE_URL + "api/admin/transaction/update-status";

  //adminwithdrat
  static const String GET_WITHDRAW_ADMIN_KOPRASI_URL =
      BASE_URL + "api/admin/withdraw";
  static const String GET_WITHDRAW_SUPER_ADMIN_URL =
      BASE_URL + "api/super/withdraw";
  static const String POST_WITHDRAW_URL = BASE_URL + "api/admin/withdraw";
  static const String POST_STATUS_WITHDRAW_URL =
      BASE_URL + "api/super/update-withdraw";
  static const String POST_STATUS_ADMIN_WITHDRAW_URL =
      BASE_URL + "api/admin/update-withdraw";

  static const String POST_STATUS_CUSTOMER_ORDER_URL =
      BASE_URL + "api/customer/transaction/update-status";

  static String GET_REPORT_TRASH_URL(GetChartRequest data) {
    return BASE_URL +
        "api/super/summary-trash-transaction?yearMonth=${data.yearMonth}&trashId=${data.trashId}";
  }
}
