import 'package:easy_localization/easy_localization.dart';
import '../../languages/locale_keys.g.dart';
import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onAction,
  });

  final String title;
  final String description;
  final VoidCallback onAction;

  // static const Color primaryColor = Color(0xffD21E6A);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            /// Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 24),

            /// Buttons
            Row(
              children: [
                /// Back button
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primerColor,
                      side: const BorderSide(color: AppColors.primerColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(LocaleKeys.cart_back.tr()),
                  ),
                ),

                const SizedBox(width: 12),

                /// Action button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onAction();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primerColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(LocaleKeys.cart_confirm.tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showActionDialog({
  required BuildContext context,
  required String title,
  required String description,
  required VoidCallback onAction,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => ActionDialog(
      title: title,
      description: description,
      onAction: onAction,
    ),
  );
}
