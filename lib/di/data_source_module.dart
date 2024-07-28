
import 'package:get_it/get_it.dart';
import 'package:rebuild_bank_sampah/services/auth/auth_repository.dart';




void initDataSourcesModule(GetIt locator) {
   locator.registerLazySingleton<AuthDataSource>(() => AuthDataSource());

}