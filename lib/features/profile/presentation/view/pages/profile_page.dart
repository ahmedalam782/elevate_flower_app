import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_icons.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/core/shared/widgets/custom_toast.dart';
import 'package:elevate_flower_app/features/profile/presentation/view/widgets/profile_header.dart';
import 'package:elevate_flower_app/features/profile/presentation/view/widgets/profile_list_item.dart';
import 'package:elevate_flower_app/features/profile/presentation/view/widgets/profile_divider.dart';
import 'package:elevate_flower_app/features/profile/presentation/view/widgets/language_bottom_sheet.dart';
import 'package:elevate_flower_app/features/profile/presentation/view/widgets/logout_confirmation_dialog.dart';
import 'package:elevate_flower_app/features/profile/presentation/view/widgets/profile_header_shimmer.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_flower_app/core/config/di/injectable_config.dart';
import 'package:elevate_flower_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:elevate_flower_app/features/profile/presentation/view_model/cubit/profile_states.dart';
import 'package:elevate_flower_app/features/profile/presentation/view_model/cubit/profile_events.dart';

import '../../../../../core/routes/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationEnabled = true;
  String _appVersion = '';
  final int _notificationCount = 3; // Badge count

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v ${packageInfo.version} - (${packageInfo.buildNumber})';
    });
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(
        currentLanguage: context.locale.languageCode,
        onLanguageSelected: (locale) {
          context.setLocale(locale);
        },
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => LogoutConfirmationDialog(
        title: LocaleKeys.profile_logout.tr().toUpperCase(),
        message: LocaleKeys.profile_logout_confirmation.tr(),
        confirmText: LocaleKeys.profile_logout.tr(),
        cancelText: LocaleKeys.global_cancel.tr(),
        onConfirm: () {
          // TODO: Implement logout logic here
          CustomToast(
            context: context,
            header: LocaleKeys.profile_logout_success.tr(),
            type: ToastificationType.success,
          ).showToast();
        },
      ),
    );
  }

  String _getCurrentLanguage() {
    return context.locale.languageCode == 'ar' ? 'العربية' : 'English';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProfileCubit>()..doIntent(ProfileEvents.loadProfileData()),
      child: Scaffold(
        backgroundColor: AppColors.whiteFF,
        appBar: AppBar(
          backgroundColor: AppColors.whiteFF,
          elevation: 0,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SvgPicture.asset(AppIcons.iconsFlower, fit: BoxFit.scaleDown),
                SizedBox(width: 8.w),
                Text(
                  LocaleKeys.global_app_name.tr(),
                  style: 20.bold.copyWith(color: AppColors.primerColor),
                ),
              ],
            ),
          ),
          actions: [
            // Notification badge
            Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w),
              child: InkWell(
                onTap: () {
                  // TODO: Navigate to notifications
                },
                child: Badge.count(
                  count: _notificationCount,
                  backgroundColor: AppColors.primerColor,
                  textColor: AppColors.whiteFF,
                  child: SvgPicture.asset(
                    AppIcons.iconsNotification,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              color: AppColors.primerColor,
              backgroundColor: AppColors.whiteFF,
              onRefresh: () async {
                context.read<ProfileCubit>().doIntent(
                  ProfileEvents.loadProfileData(),
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Profile Header
                    BlocBuilder<ProfileCubit, ProfileStates>(
                      builder: (context, state) {
                        return state.profileDataState.when(
                          initial: () => const ProfileHeaderShimmer(),
                          loading: () => const ProfileHeaderShimmer(),
                          success: (profileData) => ProfileHeader(
                            imageUrl: profileData.photo,
                            name: profileData.fullName,
                            email: profileData.email,
                            onEditTap: () async {
                              final result = await context.push(Routes.editProfile);
                              // Refresh profile data if edit was successful
                              if (result == true && context.mounted) {
                                context.read<ProfileCubit>().doIntent(
                                  ProfileEvents.loadProfileData(),
                                );
                              }
                            },
                          ),
                          error: (error) => Column(
                            children: [
                              SizedBox(height: 24.h),
                              Icon(
                                Icons.error_outline,
                                size: 60.sp,
                                color: AppColors.primerColor.withOpacity(0.5),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'Unable to load profile',
                                style: 16.semiBold.copyWith(color: AppColors.black32),
                              ),
                              SizedBox(height: 8.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 32.w),
                                child: Text(
                                  'Please check your internet connection',
                                  textAlign: TextAlign.center,
                                  style: 14.regular.copyWith(color: AppColors.gray53),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.read<ProfileCubit>().doIntent(
                                    ProfileEvents.loadProfileData(),
                                  );
                                },
                                icon: Icon(Icons.refresh, size: 18.sp),
                                label: Text('Retry', style: 14.medium),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primerColor,
                                  foregroundColor: AppColors.whiteFF,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 12.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        );
                      },
                    ),
              
                    SizedBox(height: 8.h),
                    const ProfileDivider(),
              
                    // My Orders
                    ProfileListItem(
                      iconPath: AppIcons.iconsTransactionOrder,
                      title: LocaleKeys.profile_my_orders.tr(),
                      onTap: () {
                        // TODO: Navigate to orders
                      },
                    ),
              
                    const ProfileDivider(),
              
                    // Saved Address
                    ProfileListItem(
                      iconPath: AppIcons.iconsLocation,
                      title: LocaleKeys.profile_saved_address.tr(),
                      onTap: () {
                        // TODO: Navigate to saved addresses
                      },
                    ),
              
                    const ProfileDivider(),
                    SizedBox(height: 16.h),
              
                    // Notification Toggle
                    ProfileListItem(
                      iconPath: AppIcons.iconsCheckCircle,
                      title: LocaleKeys.profile_notification.tr(),
                      trailing: Switch(
                        value: _notificationEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationEnabled = value;
                          });
                          // TODO: Update notification settings
                        },
                        activeThumbColor: AppColors.whiteFF,
                        activeTrackColor: AppColors.primerColor,
                        inactiveThumbColor: AppColors.primerColor,
                        inactiveTrackColor: AppColors.pinkF9,
                        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.transparent;
                          }
                          return AppColors.gray53.withValues(alpha: 0.3);
                        }),
                      ),
                    ),
              
                    const ProfileDivider(),
                    SizedBox(height: 16.h),
              
                    // Language
                    ProfileListItem(
                      iconPath: AppIcons.iconsTranslateLang,
                      title: LocaleKeys.profile_language.tr(),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getCurrentLanguage(),
                            style: 14.medium.copyWith(color: AppColors.primerColor),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.chevron_right,
                            size: 20.sp,
                            color: AppColors.black85,
                          ),
                        ],
                      ),
                      onTap: _showLanguageBottomSheet,
                    ),
              
                    const ProfileDivider(),
              
                    // About Us
                    ProfileListItem(
                      iconPath: AppIcons.iconsCheckCircle,
                      title: LocaleKeys.profile_about_us.tr(),
                      onTap: () {
                        // TODO: Navigate to about us
                      },
                    ),
              
                    const ProfileDivider(),
              
                    // Terms & Conditions
                    ProfileListItem(
                      iconPath: AppIcons.iconsWarning,
                      title: LocaleKeys.profile_terms_conditions.tr(),
                      onTap: () {
                        // TODO: Navigate to terms & conditions
                      },
                    ),
              
                    const ProfileDivider(),
                    SizedBox(height: 24.h),
              
                    // Logout Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: InkWell(
                        onTap: _showLogoutDialog,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.iconsLogout,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(width: 12.w),
                              Text(LocaleKeys.profile_logout.tr(), style: 14.medium),
                              const Spacer(),
                              SvgPicture.asset(AppIcons.iconsLogout),
                            ],
                          ),
                        ),
                      ),
                    ),
              
                    SizedBox(height: 32.h),
              
                    // Version
                    Text(
                      _appVersion,
                      style: 12.regular.copyWith(color: AppColors.black85),
                    ),
              
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
