
import 'package:get_it/get_it.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_data_sources.dart';
import 'package:rebuild_bank_sampah/services/trash/repository/auth_respository.dart';
void initRepositoriesModule(GetIt locator) {
  locator
      .registerLazySingleton<AuthRepository>(() => AuthRepository(locator()));
  locator
      .registerLazySingleton<TrashRepository>(() => TrashRepository(locator()));
}
