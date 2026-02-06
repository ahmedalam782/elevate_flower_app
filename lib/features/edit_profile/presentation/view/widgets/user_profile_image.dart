import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../view_model/cubit/edit_profile_cubit.dart';
import '../../view_model/cubit/edit_profile_events.dart';
import '../../view_model/cubit/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({super.key, this.imagePath});
  final String? imagePath;

  void _showImageSourceActionSheet(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(LocaleKeys.edit_profile_camera_option.tr()),
              onTap: () {
                Navigator.pop(context);
                cubit.onEvent(
                  EditProfileEvents.onPickProfilePhotoEvent(ImageSource.camera),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(LocaleKeys.edit_profile_gallery_option.tr()),
              onTap: () {
                Navigator.pop(context);
                context.read<EditProfileCubit>().onEvent(
                  EditProfileEvents.onPickProfilePhotoEvent(
                    ImageSource.gallery,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomRight,
      children: [
        BlocBuilder<EditProfileCubit, EditProfileStates>(
          buildWhen: (previous, current) =>
              previous.pickedPhoto != current.pickedPhoto,
          builder: (context, state) {
            final ImageProvider imageProvider = state.pickedPhoto != null
                ? FileImage(state.pickedPhoto!)
                : CachedNetworkImageProvider(imagePath ?? '');
            return CircleAvatar(
              radius: 40.5,
              backgroundColor: Colors.transparent,
              backgroundImage: imageProvider,
            );
          },
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.pinkF9,
            borderRadius: BorderRadius.circular(5),
          ),
          child: GestureDetector(
            onTap: () => _showImageSourceActionSheet(context),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.gray53,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
