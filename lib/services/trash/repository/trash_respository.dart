import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/trash/datasources/trash_data_sources.dart';
import 'package:rebuild_bank_sampah/services/trash/model/request/price_trash_request.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/delete_price_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/post_trash_response.dart';

class TrashRepository {
  final TrashDataSources sources;

  TrashRepository(this.sources);

  Future<Either<Failure, GetTrashResponse>> getTrash() async {
    return sources.getTrash();
  }
  Future<Either<Failure, GetTrashResponse>> getTrashSuper() async {
    return sources.getTrashSuper();
  }

  Future<Either<Failure, PostTrashResponse>> postTrashSuper(PriceTrashRequest data) async {
    return sources.postTrashSuper(data);
  }
  Future<Either<Failure, DeletePriceTrashResponse>> deleteTrashSuper(String id) async {
    return sources.deletePriceTrash(id);
  }
}
