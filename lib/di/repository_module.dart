import 'package:get_it/get_it.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_repository.dart';
import 'package:rebuild_bank_sampah/services/home/datarepository/home_repository.dart';
import 'package:rebuild_bank_sampah/services/order/repository/order_admin_data_repository.dart';
import 'package:rebuild_bank_sampah/services/product/repository/product_customer_data_repository.dart';
import 'package:rebuild_bank_sampah/services/product/repository/product_data_repository.dart';
import 'package:rebuild_bank_sampah/services/profile/repository/profile%20_data_repository.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/customer_trash_repository.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/deposit_trash_respository.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/trash_respository.dart';
import 'package:rebuild_bank_sampah/services/withdraw/datarepository/withdraw_admin_koprasi_respository.dart';
import 'package:rebuild_bank_sampah/services/withdraw/datarepository/withdrawa_super_admin_repository.dart';

void initRepositoriesModule(GetIt locator) {
  locator
      .registerLazySingleton<AuthRepository>(() => AuthRepository(locator()));
  locator
      .registerLazySingleton<TrashRepository>(() => TrashRepository(locator()));
  locator.registerLazySingleton<ProductDataRepository>(
      () => ProductDataRepository(locator()));
  locator.registerLazySingleton<DepositTrashDataRespository>(
      () => DepositTrashDataRespository(locator()));
  locator.registerLazySingleton<CustomerTrashRepository>(
      () => CustomerTrashRepository(locator()));
  locator
      .registerLazySingleton<HomeRepository>(() => HomeRepository(locator()));
  locator.registerLazySingleton<ProductCustomerDataRepository>(
      () => ProductCustomerDataRepository(locator()));
  locator.registerLazySingleton<ProfileDataRepository>(
      () => ProfileDataRepository(locator()));
  locator.registerLazySingleton<OrderAdminDataRepository>(
      () => OrderAdminDataRepository(locator()));
  locator.registerLazySingleton<WithdrawAdminKoprasiRespository>(
      () => WithdrawAdminKoprasiRespository(locator()));
  locator.registerLazySingleton<WithdrawaSuperAdminRepository>(
      () => WithdrawaSuperAdminRepository(locator()));
}
