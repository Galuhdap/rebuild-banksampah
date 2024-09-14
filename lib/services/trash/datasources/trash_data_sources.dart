
import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/services/lib/api_services.dart';
import 'package:rebuild_bank_sampah/services/lib/network_constants.dart';
import 'package:rebuild_bank_sampah/services/trash/model/response/get_trash_response.dart';

class TrashDataSources extends ApiService {
  var token;

  Future<Either<Failure, GetTrashResponse>> getTrash() async {
    final prefs = await SharedPreferencesUtils.getAuthToken();

    try {
      final response = await get(NetworkConstants.GET_TRASH_URL, header: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs}",
      });

      return Right(GetTrashResponse.fromJson(response));
    } catch (e) {
      return left(Failure(400, 'data masuk'));
    }

    // inspect(response);

    // if (response.statusC == 200) {
    //   return Right(GetTrashResponse.fromJson(response));
    // } else {
    //   return left(Failure(400, 'data masuk'));
    // }

    // return response.fold(
    // (failure) => Left(failure),
    // (response) {
    //   // Cek apakah response sukses (misalnya kode statusnya 200)
    //   if (response.statusCode == 200) {
    //     //final Map<String, dynamic> jsonResponse = json.decode(response.body);
    //     return Right(GetTrashResponse.fromJson(response));
    //   } else {
    //     return Left(Failure('Cek a'));
    //   }

    // return response.fold(
    //   (failure) => Left(failure),
    //   (response) => Right(GetTrashResponse.fromJson(response)),
    // );
  }
}
