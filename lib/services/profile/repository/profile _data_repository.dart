import 'package:dartz/dartz.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/datasources/failure.dart';
import 'package:rebuild_bank_sampah/services/profile/datasources/profile_data_sources.dart';
import 'package:rebuild_bank_sampah/services/profile/model/get_profile_response.dart';

class ProfileDataRepository {
  final ProfileDataSources sources;

  ProfileDataRepository(this.sources);

  Future<Either<Failure, GetProfileResponse>> getProfile() async {
    return sources.getProfile();
  }
}
