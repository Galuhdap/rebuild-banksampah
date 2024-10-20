import 'package:get_it/get_it.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_data_sources.dart';
import 'package:rebuild_bank_sampah/services/home/datasources/home_datasources.dart';
import 'package:rebuild_bank_sampah/services/order/datasources/order_admin_data_sources.dart';
import 'package:rebuild_bank_sampah/services/product/datasources/product_customer_data_sources.dart';
import 'package:rebuild_bank_sampah/services/product/datasources/product_data_sources.dart';
import 'package:rebuild_bank_sampah/services/profile/datasources/profile_data_sources.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/customer_deposit_trash_datasources.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/deposit_trash_data_sources.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/trash_data_sources.dart';

void initDataSourcesModule(GetIt locator) {
  locator.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  locator.registerLazySingleton<TrashDataSources>(() => TrashDataSources());
  locator.registerLazySingleton<ProductDataSources>(() => ProductDataSources());
  locator.registerLazySingleton<DepositTrashDataSources>(
      () => DepositTrashDataSources());
  locator.registerLazySingleton<CustomerDepositTrashDatasources>(
      () => CustomerDepositTrashDatasources());
  locator.registerLazySingleton<HomeDatasources>(() => HomeDatasources());
  locator.registerLazySingleton<ProductCustomerDataSources>(
      () => ProductCustomerDataSources());
  locator.registerLazySingleton<ProfileDataSources>(() => ProfileDataSources());
  locator.registerLazySingleton<OrderAdminDataSources>(() => OrderAdminDataSources());
}
