import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckoutAppBar extends AppBar {
  CheckoutAppBar({
    super.key,
    required BuildContext context,
    required String title,
  }) : super(
         systemOverlayStyle: const SystemUiOverlayStyle(
           statusBarColor: AppColors.whiteF9,
           systemNavigationBarColor: AppColors.whiteF9,
           statusBarIconBrightness: Brightness.dark,
           statusBarBrightness: Brightness.dark,
           systemNavigationBarIconBrightness: Brightness.light,
         ),
         leading: InkWell(
           onTap: () => Navigator.of(context).pop(),
           child: const Icon(
             Icons.arrow_back_ios_new,
             size: 24,
             fontWeight: FontWeight.w500,
             color: AppColors.black0C,
           ),
         ),
         title: Text(title),
         titleTextStyle: 20.medium.copyWith(color: AppColors.black0C),
         titleSpacing: -8,
         leadingWidth: 44,
       );
}
