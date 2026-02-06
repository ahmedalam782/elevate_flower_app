import '../../../../core/config/base_response/result.dart';
import '../entities/edit_profile_user_entity.dart';
import '../repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileDetailsUsecase {
  final EditProfileRepository _editProfileRepository;
  GetProfileDetailsUsecase(this._editProfileRepository);
  Future<Result<EditProfileUserEntity>> call() => _editProfileRepository.getProfileDetails();
}