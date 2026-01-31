import '../../../../core/config/base_response/result.dart';
import '../entities/edit_profile_params.dart';
import '../entities/edit_profile_user_entity.dart';
import '../repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class UpdateProfileDetailsUsecase {
  final EditProfileRepository _editProfileRepository;
  UpdateProfileDetailsUsecase(this._editProfileRepository);
  Future<Result<EditProfileUserEntity>> call(EditProfileParams params) =>
      _editProfileRepository.updateProfileDetails(params);
}
