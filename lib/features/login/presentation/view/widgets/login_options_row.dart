import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:elevate_flower_app/core/theme/app_colors.dart';
import 'package:elevate_flower_app/core/theme/app_typography.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:elevate_flower_app/features/login/presentation/view_model/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginOptionsRow extends StatelessWidget {
  const LoginOptionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: state.isRememberMe,
                  onChanged: (value) {
                    context.read<LoginCubit>().toggleRememberMe(value ?? false);
                  },
                  checkColor: AppColors.whiteF9,
                  activeColor: AppColors.primerColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
                Text(LocaleKeys.login_remember_me.tr(), style: 14.regular),
              ],
            ),
            TextButton(
              onPressed: () {
                context.push(Routes.forgetPassword);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                LocaleKeys.login_forgot_password.tr(),
                style: 14.regular.copyWith(color: AppColors.black0C),
              ),
            ),
          ],
        );
      },
    );
  }
}
