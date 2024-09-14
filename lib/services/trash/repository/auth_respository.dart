import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/trash_data_sources.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';

class TrashRepository {
  final TrashDataSources sources;

  TrashRepository(this.sources);

  Future<Either<Failure, GetTrashResponse>> getTrash() async {
    return sources.getTrash();
  }
}
