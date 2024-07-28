
import 'package:get_it/get_it.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_data_sources.dart';
void initRepositoriesModule(GetIt locator) {
  locator
      .registerLazySingleton<AuthRepository>(() => AuthRepository(locator()));
}
