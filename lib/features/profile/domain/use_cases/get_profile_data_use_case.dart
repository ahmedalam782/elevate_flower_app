import 'package:injectable/injectable.dart';
import '../../../../core/config/base_response/result.dart';
import '../entities/profile_data_entity.dart';
import '../repositories/profile_repository.dart';

@Injectable()
class GetProfileDataUseCase {
  final ProfileRepository repository;

  GetProfileDataUseCase({required this.repository});

  Future<Result<ProfileDataEntity>> call() async {
    return await repository.getProfileData();
  }
}
