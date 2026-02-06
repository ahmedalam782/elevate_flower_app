import 'edit_profile_form.dart';
import 'update_button_biulder.dart';
import 'user_detail_bloc_listener.dart';
import 'user_detail_gender_builder.dart';
import 'user_profile_image.dart';
import 'package:flutter/material.dart';

class UserDetailsColumn extends StatelessWidget {
 const UserDetailsColumn({super.key, this.imagePath});
  final String? imagePath;
  static const double _horizontalSpacing = 24;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: UserProfileImage(imagePath: imagePath)),
        const SizedBox(height: _horizontalSpacing),
        EditProfileForm(),
        const SizedBox(height: _horizontalSpacing),
        const UserDetailGenderBuilder(),
        const SizedBox(height: _horizontalSpacing),
        const UpdateButtonBiulder(),
        const UserDetailBlocListener(),
      ],
    );
  }
}
