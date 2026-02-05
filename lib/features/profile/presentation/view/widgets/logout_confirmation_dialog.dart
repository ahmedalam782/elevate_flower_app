import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/config/di/injectable_config.dart';
import '../../../../../core/config/base_state/base_state.dart';
import '../../../../../core/languages/locale_keys.g.dart';
import '../../../../../core/shared/widgets/custom_toast.dart';
import '../../../../logout/presentation/view_model/cubit/logout_cubit.dart';
import '../../../../logout/presentation/view_model/cubit/logout_events.dart';
import '../../../../logout/presentation/view_model/cubit/logout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_typography.dart';

/// Custom logout confirmation dialog with integrated logout logic
class LogoutConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  const LogoutConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Logout',
    this.cancelText = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<LogoutCubit>(),
      child: BlocConsumer<LogoutCubit, LogoutStates>(
        listener: (context, state) {
          state.logoutState.when(
            initial: () {},
            loading: () {},
            success: (_) {
              // Dialog will be auto-closed by navigation in UserHelper.clearUserData()
            },
            error: (error) {
              // Show error and allow user to try again or cancel
              Navigator.of(context).pop();
              CustomToast(
                context: context,
                header: LocaleKeys.logout_logout_error.tr(),
                type: ToastificationType.error,
              ).showToast();
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.logoutState.state == StateType.loading;

          return PopScope(
            canPop: !isLoading, // Prevent dismissing dialog during logout
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: AppColors.whiteFF,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      title,
                      style: 20.bold.copyWith(
                        color: AppColors.black32,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    // Message
                    Text(
                      message,
                      style: 16.regular.copyWith(color: AppColors.black85),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),

                    // Loading indicator or buttons
                    if (isLoading)
                      Column(
                        children: [
                          const CircularProgressIndicator(
                            color: AppColors.primerColor,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            LocaleKeys.logout_logout_loading.tr(),
                            style: 14.medium.copyWith(color: AppColors.black85),
                          ),
                        ],
                      )
                    else
                      // Buttons
                      Row(
                        children: [
                          // Cancel Button
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                side: BorderSide(
                                  color: AppColors.black85.withValues(
                                    alpha: 0.5,
                                  ),
                                  width: 1.5.w,
                                ),
                                backgroundColor: AppColors.whiteFF,
                              ),
                              child: Text(
                                cancelText,
                                style: 16.medium.copyWith(
                                  color: AppColors.black32,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Confirm Button
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Trigger logout event
                                context.read<LogoutCubit>().doAction(
                                  LogoutUserEvent(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                                backgroundColor: AppColors.primerColor,
                                elevation: 0,
                              ),
                              child: Text(
                                confirmText,
                                style: 16.semiBold.copyWith(
                                  color: AppColors.whiteFF,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
