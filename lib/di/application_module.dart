import 'package:get_it/get_it.dart';
import 'package:rebuild_bank_sampah/di/data_source_module.dart';
import 'package:rebuild_bank_sampah/di/repository_module.dart';

final locator = GetIt.instance;

Future<void> init() async {
  initDataSourcesModule(locator);
  initRepositoriesModule(locator);
}
