class NetworkConstants {
  //static const String BASE_URL = "https://dev.api.banksampah.techlinesolution.site/";
  static const String BASE_URL = "http://77.37.44.223:3000/";
  //static const String BASE_URL_DEV = "https://localhost:3000/";
  //static const String BASE_URL_PROD = "https://dev.api.enthusias.id";

  //login
  static const String POST_LOGIN_URL = BASE_URL + "api/login";
  static const String GET_REGISTER_URL = BASE_URL + "api/super/users";
  static const String GET_ROLE_URL = BASE_URL + "api/super/role";
  static const String POST_REGISTER_URL = BASE_URL + "api/super/register";

  //trash
  static const String GET_TRASH_URL = BASE_URL + "api/weigher/trash";
  static const String GET_TRASH_SUPER_URL = BASE_URL + "api/super/trash";
  static const String GET_DEPOSIT_TRASH_URL =
      BASE_URL + "api/weigher/trash/deposit";
  static const String GET_USER_DEPOSIT_TRASH_URL =
      BASE_URL + "api/weigher/users";
  static const String POST_DEPOSIT_TRASH_URL =
      BASE_URL + "api/weigher/trash/deposit";
  static String DELETE_DEPOSIT_TRASH_URL(String id) {
    return BASE_URL + "api/weigher/trash/deposit/$id";
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

  //super
  static const String POST_SUPER_TRASH_URL = BASE_URL + "api/super/trash";

  //profile

  static String GET_CUSTOMER_BALANCE_URL(String id) {
    return BASE_URL + "api/customer/balance/$id";
  }

  static String GET_PROFILE_CUSTOMER_URL(String id) {
    return BASE_URL + "api/customer/profile/$id";
  }

  static const String GET_SUMMARY_WEIGHET_URL =
      BASE_URL + "api/weigher/summary";

  //Product
  static const String GET_PRODUCT_URL = BASE_URL + "api/admin/products";
  static const String POST_PRODUCT_URL = BASE_URL + "api/admin/products";
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
}
