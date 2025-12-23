import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_flower_app/core/languages/locale_keys.g.dart';
import 'package:elevate_flower_app/core/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: LocaleKeys.register_have_account.tr(),
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: LocaleKeys.register_login_button.tr(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.primary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push(Routes.login);
              },
          ),
        ],
      ),
    );
  }
}
